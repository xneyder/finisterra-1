import os
import subprocess
import click

@click.command()
@click.argument('root_folder', type=click.Path(exists=True))
@click.option('--output-file', '-o', required=True, help='Path to the output Excel file.')
def process_all_subfolders(root_folder, output_file):
    for folder_name in os.listdir(root_folder):
        subdir = os.path.join(root_folder, folder_name)
        
        if not os.path.isdir(subdir):
            continue

        sheet_name = os.path.basename(subdir)
        print(f'Processing {subdir}...')
        json_files = [os.path.join(subdir, f) for f in os.listdir(subdir) if f.endswith('.tfstate')]

        for json_file in json_files:
            subprocess.run(['python', 'tfstate2xls.py', '-o', output_file, '-s', sheet_name, json_file])

if __name__ == '__main__':
    process_all_subfolders()
