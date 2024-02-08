import os
import http
import json

def auth(payload):
    api_token = os.environ.get('FT_API_TOKEN')
    if not api_token:
        # Do the redirect here to open an account and get a new token
        print("FT_API_TOKEN environment variable is not defined.")
        exit()
    api_host = os.environ.get('API_HOST', 'localhost')
    api_port = 8000
    api_path = '/api/auth/'

    conn = http.client.HTTPConnection(api_host, api_port)
    headers = {'Content-Type': 'application/json', "Authorization": "Bearer " + api_token}

    payload_json = json.dumps(payload, default=list)
    conn.request('POST', api_path, body=payload_json, headers=headers)
    response = conn.getresponse()
    if response.status == 200:
        return True
    else:
        print(f"Error: {response.status} - {response.reason}")
        exit()

