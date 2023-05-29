import json
import subprocess
import os


class Terraform:
    def __init__(self):
        pass

    def tf_plan(self, tf_path):
        print("Running terraform plan...")
        try:
            os.chdir(tf_path)
        except FileNotFoundError as e:
            print(f"Failed to change directory to {tf_path}: {e}")
            return None

        plan_file = os.path.join("/tmp/", "plan.out")
        try:
            subprocess.run(["terraform", "init"], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Failed to run 'terraform init': {e}")
            return None

        try:
            subprocess.run(
                ["terraform", "plan", "-out", plan_file], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Failed to run 'terraform plan': {e}")
            return None

        try:
            json_plan_result = subprocess.run(
                ["terraform", "show", "-json", plan_file], capture_output=True, text=True, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Failed to run 'terraform show': {e}")
            return None

        try:
            json_plan = json.loads(json_plan_result.stdout)
        except json.JSONDecodeError as e:
            print(f"Failed to decode JSON: {e}")
            return None

        return json_plan
