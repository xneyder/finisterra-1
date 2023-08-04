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


load_dotenv()


class Git:

    def __init__(self, github_installation_id, git_repo_id, git_repo_path, local_path, git_repo_branch, git_target_branch, workspace_id):
        self.github_installation_id = github_installation_id
        self.git_repo_id = git_repo_id
        self.git_repo_path = git_repo_path
        self.local_path = local_path
        self.git_repo_branch = "branch/" + git_repo_branch
        self.git_target_branch = git_target_branch
        self.workspace_id = workspace_id

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

    def clone_repo(self):
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

    def create_pr_with_files(self):

        # clean the destination directory
        if os.path.exists(self.destination_dir):
            shutil.rmtree(self.destination_dir)

        # Copy the new files into the cloned repository
        for file in os.listdir(self.local_path):
            # Create the directory if it does not exist
            os.makedirs(self.destination_dir, exist_ok=True)
            if file.endswith('.tf'):
                shutil.copy(os.path.join(
                    self.local_path, file), self.destination_dir)

        self.create_gitignore_file(self.destination_dir)

        # Create a digest file with a random hash
        # self.create_digest_file(self.destination_dir)

        # Stage and commit the changes
        self.repo.git.add(all=True)

        # Check for changes
        if not self.repo.is_dirty():
            print("No changes detected. No commits will be made.")
        else:
            self.repo.git.commit('-m', 'Updated files')

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
            "body": f"Updated files for {self.git_repo_path}\n\nworkspace: {encrypted_text}",
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
            "# Ignore override files as they can contain sensitive information\n"
            "override.tf\n"
            "override.tf.json\n"
            "*_override.tf\n"
            "*_override.tf.json\n"
            "\n"
            "# Ignore CLI configuration files\n"
            ".terraformrc\n"
            "terraform.rc\n"
            ".terraform.lock.hcl"
        )

        with open(f'{path}/.gitignore', 'w') as file:
            file.write(gitignore_content)
