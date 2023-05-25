import os
import jwt
import time
import http.client
import json
from dotenv import load_dotenv

import git
import shutil

load_dotenv()


def get_installation_token(app_id, pem, github_installation_id):
    header = {"Accept": "application/vnd.github.v3+json"}

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
        "GET", f"/app/installations/{github_installation_id}", headers=headers)

    res = conn.getresponse()
    data = res.read()

    json_data = json.loads(data.decode("utf-8"))
    organization = json_data.get('account').get('login')

    conn.request(
        "POST", f"/app/installations/{github_installation_id}/access_tokens", headers=headers)

    res = conn.getresponse()
    data = res.read()

    json_data = json.loads(data.decode("utf-8"))
    token = json_data.get('token')

    return token, organization


def create_pr_with_files(github_installation_id, git_repo_name, git_repo_path, local_path, git_repo_branch, git_target_branch):
    app_id = os.getenv("GITHUB_APP_ID")
    pem = os.getenv("GITHUB_APP_PEM")

    installation_token, organization = get_installation_token(
        app_id, pem, github_installation_id)

    # Clone the repository
    clone_url = f"https://x-access-token:{installation_token}@github.com/{organization}/{git_repo_name}.git"
    clone_dir = os.path.join(os.getcwd(), "cloned_repo")
    if os.path.exists(clone_dir):
        shutil.rmtree(clone_dir)
    repo = git.Repo.clone_from(clone_url, clone_dir)

    # Checkout to the branch or create it if it does not exist
    try:
        repo.git.checkout(git_repo_branch)
    except git.exc.GitCommandError as e:
        # Branch does not exist, create it
        repo.git.checkout("-b", git_repo_branch)

    # Copy the new files into the cloned repository
    for file in os.listdir(local_path):
        destination_dir = os.path.join(clone_dir, git_repo_path)
        # Create the directory if it does not exist
        os.makedirs(destination_dir, exist_ok=True)
        if file.endswith('.tf'):
            shutil.copy(os.path.join(local_path, file), destination_dir)

    # Stage and commit the changes
    repo.git.add(all=True)

    # Check for changes
    if not repo.is_dirty():
        print("No changes detected. No commits will be made.")
        return

    repo.git.commit('-m', 'Updated files')

    # Push the changes
    try:
        repo.git.push('--set-upstream', 'origin', git_repo_branch)
    except git.exc.GitCommandError as e:
        # Branch does not exist in remote, create it and push again
        repo.git.push('-u', 'origin', git_repo_branch)

    # Check if a pull request already exists
    conn = http.client.HTTPSConnection("api.github.com")
    headers = {
        'User-Agent': 'GitHub App',
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer ' + str(installation_token),
        'Content-Type': 'application/json'
    }
    conn.request(
        "GET", f"/repos/{organization}/{git_repo_name}/pulls", headers=headers)
    res = conn.getresponse()
    data = res.read()
    if res.status != 200:
        print(f"Failed to retrieve pull requests. Response: {data.decode()}")
        return
    else:
        pulls = json.loads(data.decode())
        for pull in pulls:
            if pull['head']['ref'] == git_repo_branch:
                print(
                    f"A pull request already exists for branch {git_repo_branch}")
                return

    # Create a pull request
    body = json.dumps({
        "title": f"{git_repo_path} updates",
        "body": "Updated files",
        "head": git_repo_branch,
        "base": git_target_branch
    })
    conn.request(
        "POST", f"/repos/{organization}/{git_repo_name}/pulls", headers=headers, body=body)
    res = conn.getresponse()
    data = res.read()
    if res.status != 201:
        print(f"Failed to create pull request. Response: {data.decode()}")
    else:
        print(
            f"Successfully created pull request #{json.loads(data.decode())['number']}")

    # Remove the cloned directory
    shutil.rmtree(clone_dir)
