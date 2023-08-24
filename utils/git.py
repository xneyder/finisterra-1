import hashlib
import random
import string

import jwt
import time
import http.client
import json
from dotenv import load_dotenv
import os

from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Random import get_random_bytes
from Crypto.Hash import SHA256

import base64

import git
import shutil

from utils.filesystem import create_root_terragrunt

import re


load_dotenv()


class Git:

    def __init__(self, github_installation_id, git_repo_id, git_repo_path, local_path, git_repo_branch, git_target_branch, workspace_id, s3Bucket, aws_region, dynamoDBTable, state_key):
        self.github_installation_id = github_installation_id
        self.git_repo_id = git_repo_id
        self.git_repo_path = git_repo_path
        self.local_path = local_path
        self.git_repo_branch = "branch/" + git_repo_branch
        self.git_target_branch = git_target_branch
        self.workspace_id = workspace_id
        self.s3Bucket = s3Bucket
        self.aws_region = aws_region
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key

        self.clone_dir = os.path.join("/tmp/", "cloned_repo")
        if os.path.exists(self.clone_dir):
            print(f"Removing cloned repo {self.clone_dir}")
            shutil.rmtree(self.clone_dir)

        app_id = os.getenv("GITHUB_APP_ID")
        pem = os.getenv("GITHUB_APP_PEM")

        self.get_installation_token(app_id, pem)

        self.git_repo_name = self.get_repo_name()

        self.clone_repo()

        self.destination_dir = os.path.join(self.clone_dir, self.git_repo_path)

        self.merged = False

    @staticmethod
    def create_random_hash(length=10):
        """Create a random string of fixed length."""
        letters = string.ascii_lowercase
        result_str = ''.join(random.choice(letters) for _ in range(length))
        return hashlib.sha256(result_str.encode()).hexdigest()

    def create_digest_file(self, dir_path):
        """Create a file named 'digest' with a random hash inside."""
        with open(os.path.join(dir_path, 'digest'), 'w') as f:
            f.write(self.create_random_hash())

    def get_repo_name(self):
        conn = http.client.HTTPSConnection("api.github.com")

        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
        }

        conn.request(
            "GET", f"/repositories/{self.git_repo_id}", headers=headers)

        res = conn.getresponse()
        data = res.read()

        json_data = json.loads(data.decode("utf-8"))
        return json_data.get('name')

    def get_installation_token(self, app_id, pem):
        payload = {
            "iat": int(time.time()),
            "exp": int(time.time()) + (10 * 60),
            "iss": app_id
        }
        encoded = jwt.encode(payload, pem, algorithm="RS256")

        conn = http.client.HTTPSConnection("api.github.com")

        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(encoded),
        }

        conn.request(
            "GET", f"/app/installations/{self.github_installation_id}", headers=headers)

        res = conn.getresponse()

        data = res.read()

        json_data = json.loads(data.decode("utf-8"))
        self.organization = json_data.get('account').get('login')

        conn.request(
            "POST", f"/app/installations/{self.github_installation_id}/access_tokens", headers=headers)

        res = conn.getresponse()
        data = res.read()

        json_data = json.loads(data.decode("utf-8"))
        self.installation_token = json_data.get('token')

    def branch_exists(self):
        """
        Check if the branch exists on the remote repository.
        :return: bool, True if the branch exists, False otherwise.
        """
        conn = http.client.HTTPSConnection("api.github.com")
        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
        }

        conn.request(
            "GET", f"/repos/{self.organization}/{self.git_repo_name}/branches", headers=headers)
        res = conn.getresponse()
        data = res.read()

        if res.status == 200:
            branches = json.loads(data.decode("utf-8"))
            for branch in branches:
                if branch['name'] == self.git_repo_branch:
                    return True
        return False

    def get_pull_request_status(self):
        """
        Check if a pull request (PR) exists for the branch and return its status (open or closed).
        :return: str, status of the pull request if it exists, None otherwise.
        """
        conn = http.client.HTTPSConnection("api.github.com")
        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
            'Content-Type': 'application/json'
        }

        conn.request(
            "GET", f"/repos/{self.organization}/{self.git_repo_name}/pulls?state=all", headers=headers)
        res = conn.getresponse()
        data = res.read()

        if res.status == 200:
            pulls = json.loads(data.decode("utf-8"))
            for pull in pulls:
                if pull['head']['ref'] == self.git_repo_branch:
                    return pull['state']

        return None

    def delete_branch(self):
        """
        Delete the branch from the remote repository.
        """
        conn = http.client.HTTPSConnection("api.github.com")
        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
        }

        conn.request(
            "DELETE", f"/repos/{self.organization}/{self.git_repo_name}/git/refs/heads/{self.git_repo_branch}", headers=headers)
        res = conn.getresponse()
        data = res.read()

        if res.status == 204:
            print(f"Successfully deleted branch {self.git_repo_branch}")
        else:
            print(
                f"Failed to delete branch {self.git_repo_branch}. Response: {data.decode()}")

    def clone_repo(self):

        branch_exists = self.branch_exists()
        pr_status = self.get_pull_request_status()

        if (pr_status == "closed" or not pr_status) and branch_exists:
            self.delete_branch()

        # Clone the repository
        clone_url = f"https://x-access-token:{self.installation_token}@github.com/{self.organization}/{self.git_repo_name}.git"

        self.repo = git.Repo.clone_from(clone_url, self.clone_dir)

        # Checkout to the branch or create it if it does not exist
        try:
            self.repo.git.checkout(self.git_repo_branch)
        except git.exc.GitCommandError as e:
            # Branch does not exist, create it
            print(
                f'Branch {self.git_repo_branch} does not exist. Creating it...')
            self.repo.git.checkout("-b", self.git_repo_branch)

    def encrypt(self, plain_text):
        secret_key = os.getenv("GITHUB_PR_SECRET")
        # Hash the secret key
        hashed_key = SHA256.new(secret_key.encode()).digest()
        # Use the hashed key instead of the original secret key
        cipher = AES.new(hashed_key, AES.MODE_CBC)
        ct_bytes = cipher.encrypt(pad(plain_text.encode(), AES.block_size))
        iv = base64.b64encode(cipher.iv).decode('utf-8')
        ct = base64.b64encode(ct_bytes).decode('utf-8')
        return iv + ":" + ct

    def get_dependency_paths(self, filename="terragrunt.hcl"):
        paths = []

        # Check if the file exists
        if not os.path.exists(filename):
            return paths

        # Open the file and read its contents
        with open(filename, 'r') as file:
            content = file.read()

            # Use regex to extract the paths
            match = re.search(
                r'dependencies\s*{\s*paths\s*=\s*\[(.*?)\]\s*}', content)
            if match:
                paths_str = match.group(1)
                paths = [path.strip().strip('"')
                         for path in paths_str.split(",")]

        return paths

    def create_pr_with_files(self):

        # clean the destination directory
        if os.path.exists(self.destination_dir):
            shutil.rmtree(self.destination_dir)

        # Clean up destination
        for dirpath, _, filenames in os.walk(self.destination_dir):
            for file in filenames:
                os.remove(os.path.join(dirpath, file))

        # Copy the new files into the cloned repository
        for dirpath, _, filenames in os.walk(self.local_path):
            # Construct the destination directory path
            relative_path = os.path.relpath(dirpath, self.local_path)
            destination_subfolder = os.path.join(
                self.destination_dir, relative_path)

            # Create the directory in the destination if it doesn't exist
            os.makedirs(destination_subfolder, exist_ok=True)

            for file in filenames:
                if file.endswith('.tf') or file.endswith('.hcl'):
                    shutil.copy(os.path.join(dirpath, file),
                                destination_subfolder)
                    if file == "terragrunt.hcl":
                        dependencies = self.get_dependency_paths(
                            os.path.join(dirpath, file))
                        for dependency in dependencies:
                            os.makedirs(os.path.join(self.destination_dir,
                                        dependency), exist_ok=True)

        self.create_gitignore_file(os.path.join(
            self.clone_dir, "finisterra", "generated"))

        # Generate terragrunt.hcl
        create_root_terragrunt(
            self.s3Bucket, self.aws_region, self.dynamoDBTable, self.state_key, os.path.join(
                self.clone_dir, self.state_key))

        # Create a digest file with a random hash
        # self.create_digest_file(self.destination_dir)

        # Stage and commit the changes
        self.repo.git.add(all=True)

        # Check for changes
        if not self.repo.is_dirty():
            print("No changes detected. No commits will be made.")
        else:
            self.repo.git.commit('-m', 'Automatic scan')

        # Push the changes regardless of changes to the repo
        try:
            self.repo.git.push('--set-upstream', 'origin',
                               self.git_repo_branch)
        except git.exc.GitCommandError as e:
            # Branch does not exist in remote, create it and push again
            self.repo.git.push('-u', 'origin', self.git_repo_branch)

        # Check if a pull request already exists
        pr_number = self.get_pull_request()

        # If PR does not exist, create one
        if pr_number is None:
            pr_number = self.create_pull_request()

        # If directory does not exist in target branch, merge the PR
        # if pr_number is not None and not self.directory_exists_on_branch(self.git_target_branch):
        #     self.merge_pull_request(pr_number)

    def get_pull_request(self):
        conn = http.client.HTTPSConnection("api.github.com")
        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
            'Content-Type': 'application/json'
        }

        pr_number = None
        self.pr_url = None
        page = 1

        while True:
            conn.request(
                "GET", f"/repos/{self.organization}/{self.git_repo_name}/pulls?state=open&page={page}", headers=headers)
            res = conn.getresponse()
            data = res.read()

            if res.status != 200:
                print(
                    f"Failed to retrieve pull requests. Response: {data.decode()}")
                return pr_number

            pulls = json.loads(data.decode())

            for pull in pulls:
                if pull['head']['ref'] == self.git_repo_branch:
                    print(
                        f"A pull request already exists for branch {self.git_repo_branch}")
                    pr_number = pull['number']
                    # Save the pull request url
                    self.pr_url = pull['html_url']
                    return pr_number

            # Check Link header to see if there's a next page
            link_header = res.getheader('Link')
            if link_header is None or 'rel="next"' not in link_header:
                # We've read all the pages
                break

            page += 1

        return pr_number

    def create_pull_request(self):
        encrypted_text = self.encrypt(str(self.workspace_id))

        conn = http.client.HTTPSConnection("api.github.com")
        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
            'Content-Type': 'application/json'
        }
        body = json.dumps({
            "title": f"{self.git_repo_branch}",
            "body": f"Updated files for {self.git_repo_path}\n\nworkspace: {encrypted_text} \n\n[skip ft]",
            "head": self.git_repo_branch,
            "base": self.git_target_branch
        })
        conn.request(
            "POST", f"/repos/{self.organization}/{self.git_repo_name}/pulls", headers=headers, body=body)
        res = conn.getresponse()
        data = res.read()
        pr_number = None
        self.pr_url = None  # Initialize pr_url
        if res.status != 201:
            print(f"Failed to create pull request. Response: {data.decode()}")
        else:
            response_data = json.loads(data.decode())
            pr_number = response_data['number']
            # Save the pull request url
            self.pr_url = response_data['html_url']
            print(f"Successfully created pull request #{pr_number}")
        return pr_number

    def merge_pull_request(self, pr_number):
        # Check if the directory exists on the target branch
        if not self.directory_exists_on_branch(self.git_target_branch):
            # Merge the pull request
            conn = http.client.HTTPSConnection("api.github.com")
            headers = {
                'User-Agent': 'GitHub App',
                'Accept': 'application/vnd.github+json',
                'Authorization': 'Bearer ' + str(self.installation_token),
                'Content-Type': 'application/json'
            }
            body = json.dumps({
                "commit_title": "Automatically merged by script",
            })
            conn.request(
                "PUT", f"/repos/{self.organization}/{self.git_repo_name}/pulls/{pr_number}/merge", headers=headers, body=body)
            res = conn.getresponse()
            data = res.read()
            if res.status != 200:
                print(
                    f"Failed to merge pull request. Response: {data.decode()}")
            else:
                print(
                    f"Successfully merged pull request #{pr_number}")
                self.merged = True

    def directory_exists_on_branch(self, branch):
        # Construct the URL for the GitHub API call
        url = f"/repos/{self.organization}/{self.git_repo_name}/contents/{self.git_repo_path}?ref={branch}"

        conn = http.client.HTTPSConnection("api.github.com")
        headers = {
            'User-Agent': 'GitHub App',
            'Accept': 'application/vnd.github+json',
            'Authorization': 'Bearer ' + str(self.installation_token),
        }

        conn.request("GET", url, headers=headers)
        res = conn.getresponse()
        data = res.read()

        if res.status == 200:
            return True
        elif res.status == 404:
            return False
        else:
            print(f"Error while checking if directory exists: {data.decode()}")
            return False

    def checkout_commit(self, commit_hash):
        """
        Checkout to a specific commit
        :param commit_hash: str, commit hash
        """
        try:
            self.repo.git.checkout(commit_hash)
        except git.exc.GitCommandError as e:
            print(
                f"An error occurred while trying to checkout to commit {commit_hash}. Error: {str(e)}")

    def create_gitignore_file(self, path):
        gitignore_content = (
            "# Local .terraform directories\n"
            "**/.terraform/*\n"
            "\n"
            "# .tfstate files\n"
            "*.tfstate\n"
            "*.tfstate.*\n"
            "\n"
            "# Crash log files\n"
            "crash.log\n"
            "\n"
            "# Ignore all .tfvars files, which are likely to contain sentitive data\n"
            "*.tfvars\n"
            "\n"
            "# Ignore CLI configuration files\n"
            ".terraformrc\n"
            ".terragrunt*\n"
            "terraform.rc\n"
            ".terraform.lock.hcl"
        )

        with open(f'{path}/.gitignore', 'w') as file:
            file.write(gitignore_content)
