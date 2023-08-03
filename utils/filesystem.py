

def create_version_file():
    with open("version.tf", "w") as version_file:
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
        # backend_file.write(f'    dynamodb_table = "{dynamodb_table}"\n')
        backend_file.write('    encrypt        = true\n')
        backend_file.write('  }\n')
        backend_file.write('}\n')


def create_data_file():
    with open("data.tf", "w") as data_file:
        data_file.write('data "aws_caller_identity" "current" {}\n')
        data_file.write('data "aws_region" "current" {}\n')


def create_locals_file(region):
    with open("locals.tf", "w") as locals_file:
        locals_file.write('locals {\n')
        locals_file.write('  aws_region = data.aws_region.current.name\n')
        locals_file.write(
            '  aws_account_id = data.aws_caller_identity.current.account_id\n')
        aws_partition = 'aws-us-gov' if 'gov' in region else 'aws'
        locals_file.write(f'  aws_partition = "{aws_partition}"\n')
        locals_file.write('}\n')
