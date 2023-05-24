import os
import jwt
import time
import http.client
import json
import base64
from dotenv import load_dotenv

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

    conn = http.client.HTTPSConnection("api.github.com")

    headers = {
        'User-Agent': 'GitHub App',
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer ' + str(installation_token),
        'Content-Type': 'application/json'
    }

    conn.request(
        "GET", f"/repos/{organization}/{git_repo_name}/git/ref/heads/{git_target_branch}", headers=headers)
    res = conn.getresponse()
    data = res.read()
    json_data = json.loads(data.decode("utf-8"))
    base_sha = json_data['object']['sha']

    blobs = []
    for file in os.listdir(local_path):
        file_path = os.path.join(local_path, file)
        if os.path.isfile(file_path) and file.endswith('.tf'):
            content = ''
            with open(file_path, 'r') as file_content:
                content = file_content.read()

            content_encoded = base64.b64encode(content.encode()).decode()
            conn.request("POST", f"/repos/{organization}/{git_repo_name}/git/blobs", headers=headers, body=json.dumps({
                "content": content_encoded,
                "encoding": "base64"
            }))
            res = conn.getresponse()
            data = res.read()
            if res.status != 201:  # If the blob is not created successfully
                print(
                    f"Failed to create blob for file {file}. Response: {data.decode()}")
            else:
                blob_sha = json.loads(data)['sha']
                blobs.append({
                    'path': f"{git_repo_path}/{file}",
                    'mode': '100644',
                    'type': 'blob',
                    'sha': blob_sha
                })

    # Create a tree with the blobs
    conn.request("POST", f"/repos/{organization}/{git_repo_name}/git/trees", headers=headers, body=json.dumps({
        "base_tree": base_sha,
        "tree": blobs
    }))
    res = conn.getresponse()
    data = res.read()
    if res.status != 201:
        print(f"Failed to create tree. Response: {data.decode()}")
    else:
        tree_sha = json.loads(data)['sha']

        # Get the current commit SHA of the branch
        conn.request(
            "GET", f"/repos/{organization}/{git_repo_name}/git/refs/heads/{git_repo_branch}", headers=headers)
        res = conn.getresponse()
        data = res.read()
        if res.status != 200:
            print(f"Failed to get reference. Response: {data.decode()}")
        else:
            branch_sha = json.loads(data)['object']['sha']

        # Create a commit using the tree
        conn.request("POST", f"/repos/{organization}/{git_repo_name}/git/commits", headers=headers, body=json.dumps({
            "message": "commit message",
            "tree": tree_sha,
            "parents": [branch_sha]
        }))
        res = conn.getresponse()
        data = res.read()
        if res.status != 201:
            print(f"Failed to create commit. Response: {data.decode()}")
        else:
            commit_sha = json.loads(data)['sha']

            # Update the reference to point to the new commit
            conn.request("PATCH", f"/repos/{organization}/{git_repo_name}/git/refs/heads/{git_repo_branch}", headers=headers, body=json.dumps({
                "sha": commit_sha,
                "force": False
            }))
            res = conn.getresponse()
            data = res.read()
            if res.status != 200:
                print(f"Failed to update reference. Response: {data.decode()}")

    conn.request(
        "GET", f"/repos/{organization}/{git_repo_name}/pulls?state=open", headers=headers)
    res = conn.getresponse()
    data = res.read()
    if res.status != 200:
        print(f"Failed to retrieve pull requests. Response: {data.decode()}")
    else:
        pulls = json.loads(data)
        for pull in pulls:
            if pull['head']['ref'] == git_repo_branch:
                print(
                    f"A pull request already exists for branch {git_repo_branch}")
                return

    # Create a pull request
    conn.request("POST", f"/repos/{organization}/{git_repo_name}/pulls", headers=headers, body=json.dumps({
        "title": f"{git_repo_path} updates",
        "body": "Terraform updates",
        "head": git_repo_branch,
        "base": git_target_branch
    }))
    res = conn.getresponse()
    data = res.read()
    if res.status != 201:  # If the pull request is not created successfully
        print(f"Failed to create pull request. Response: {data.decode()}")

    # Print the repo path
    print(f"Repo path: {organization}/{git_repo_name}")
