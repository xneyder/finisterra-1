


def create_version_file():
    with open("version.tf", "w") as version_file:
        version_file.write('terraform {\n')
        version_file.write('  required_providers {\n')
        version_file.write('  aws = {\n')
        version_file.write('  source  = "hashicorp/aws"\n')
        version_file.write('  version = "~> 4.0"\n')
        version_file.write('}\n')
        version_file.write('}\n')
        version_file.write('}\n')