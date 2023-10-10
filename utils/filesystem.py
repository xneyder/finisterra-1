import os
import subprocess


def create_version_file():
    with open("versions.tf", "w") as version_file:
        version_file.write('terraform {\n')
        version_file.write('  required_providers {\n')
        version_file.write('  aws = {\n')
        version_file.write('  source  = "hashicorp/aws"\n')
        version_file.write('  version = "~> 5.0"\n')
        version_file.write('}\n')
        version_file.write('}\n')
        version_file.write('}\n')


def create_backend_file(bucket: str, key: str, region: str, dynamodb_table: str):
    with open("backend.tf", "w") as backend_file:
        backend_file.write('terraform {\n')
        backend_file.write('  backend "s3" {\n')
        backend_file.write(f'    bucket         = "{bucket}"\n')
        backend_file.write(f'    key            = "{key}"\n')
        backend_file.write(f'    region         = "{region}"\n')
        backend_file.write(f'    dynamodb_table = "{dynamodb_table}"\n')
        backend_file.write('    encrypt        = true\n')
        backend_file.write('  }\n')
        backend_file.write('}\n')


def create_data_file():
    with open("data.tf", "w") as data_file:
        data_file.write('data "aws_caller_identity" "current" {}\n')
        data_file.write('data "aws_region" "current" {}\n')


def create_locals_file():
    with open("locals.tf", "w") as locals_file:
        locals_file.write('locals {\n')
        locals_file.write('  aws_region = data.aws_region.current.name\n')
        locals_file.write(
            '  aws_account_id = data.aws_caller_identity.current.account_id\n')
        locals_file.write(
            f'  aws_partition = can(regex("gov", local.aws_region)) ? "aws-us-gov" : "aws"\n')
        locals_file.write('}\n')


def create_root_terragrunt(bucket, region, dynamodb_table, key, destination="."):
    file_path = os.path.join(destination, "terragrunt.hcl")
    with open(file_path, "w") as terragrunt:
        # versions.tf
        terragrunt.write('generate "versions.tf" {\n')
        terragrunt.write('path      = "versions.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('terraform {\n')
        terragrunt.write('  required_providers {\n')
        terragrunt.write('  aws = {\n')
        terragrunt.write('  source  = "hashicorp/aws"\n')
        terragrunt.write('  version = "~> 5.0"\n')
        terragrunt.write('}\n')
        terragrunt.write('}\n')
        terragrunt.write('}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

        # backend.tf
        terragrunt.write('generate "backend.tf" {\n')
        terragrunt.write('path      = "backend.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('terraform {\n')
        terragrunt.write('  backend "s3" {}\n')
        terragrunt.write('}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

        # remote_state
        terragrunt.write('remote_state {\n')
        terragrunt.write('  backend = "s3"\n')
        terragrunt.write('  config = {\n')
        terragrunt.write(f'    bucket         = "{bucket}"\n')
        terragrunt.write(
            f'    key            = "{key}/${{path_relative_to_include()}}/terraform.tfstate"\n')
        terragrunt.write(f'    region         = "{region}"\n')
        terragrunt.write('    encrypt        = true\n')
        terragrunt.write(f'    dynamodb_table = "{dynamodb_table}"\n')
        terragrunt.write('  }\n')
        terragrunt.write('}\n\n')

        # data.tf
        terragrunt.write('generate "data.tf" {\n')
        terragrunt.write('path      = "data.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('data "aws_caller_identity" "current" {}\n')
        terragrunt.write('data "aws_region" "current" {}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

        # locals.tf
        terragrunt.write('generate "locals.tf" {\n')
        terragrunt.write('path      = "locals.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('locals {\n')
        terragrunt.write('  aws_region = data.aws_region.current.name\n')
        terragrunt.write(
            '  aws_account_id = data.aws_caller_identity.current.account_id\n')
        terragrunt.write(
            f'  aws_partition = can(regex("gov", local.aws_region)) ? "aws-us-gov" : "aws"\n')
        terragrunt.write('}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

    # original_directory = os.getcwd()
    os.chdir(destination)
    subprocess.run(["terragrunt", "hclfmt"], check=True)
    # os.chdir(original_directory)


def create_tmp_terragrunt(base_path):
    current_path = os.getcwd()
    print("current_path", current_path)
    # Create the base_path directory if it doesn't exist
    if not os.path.exists(base_path):
        os.makedirs(base_path)
    file_path = os.path.join(base_path, "terragrunt.hcl")
    with open(file_path, "w") as terragrunt:
        # versions.tf
        terragrunt.write('generate "versions.tf" {\n')
        terragrunt.write('path      = "versions.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('terraform {\n')
        terragrunt.write('  required_providers {\n')
        terragrunt.write('  aws = {\n')
        terragrunt.write('  source  = "hashicorp/aws"\n')
        terragrunt.write('  version = "~> 5.0"\n')
        terragrunt.write('}\n')
        terragrunt.write('}\n')
        terragrunt.write('}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

        # data.tf
        terragrunt.write('generate "data.tf" {\n')
        terragrunt.write('path      = "data.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('data "aws_caller_identity" "current" {}\n')
        terragrunt.write('data "aws_region" "current" {}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

        # locals.tf
        terragrunt.write('generate "locals.tf" {\n')
        terragrunt.write('path      = "locals.tf"\n')
        terragrunt.write('if_exists = "skip"\n')
        terragrunt.write('contents  = <<EOF\n')
        terragrunt.write('locals {\n')
        terragrunt.write('  aws_region = data.aws_region.current.name\n')
        terragrunt.write(
            '  aws_account_id = data.aws_caller_identity.current.account_id\n')
        terragrunt.write(
            f'  aws_partition = can(regex("gov", local.aws_region)) ? "aws-us-gov" : "aws"\n')
        terragrunt.write('}\n')
        terragrunt.write('EOF\n')
        terragrunt.write('}\n\n')

    print("file_path", file_path)
    # Assuming file_path is a variable that contains the path to your file
    with open(file_path, 'r') as file:
        contents = file.read()
        print(contents)


def create_gitignore_file(destination):
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
        ".terraform.lock.hcl\n\n"
        "# terragrunt generated files\n"
        "backend.tf\n"
        "data.tf\n"
        "locals.tf\n"
        "versions.tf\n"
    )

    with open(f'{destination}/.gitignore', 'w') as file:
        file.write(gitignore_content)
