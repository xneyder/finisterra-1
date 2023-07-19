

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
