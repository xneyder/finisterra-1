import click
import os
import json
from openpyxl import Workbook
from openpyxl.styles import Font
from openpyxl.comments import Comment

@click.command()
@click.option('--output-file', '-o', required=True, help='Path to the output Excel file.')
@click.argument('json-file', type=click.Path(exists=True))
def main(output_file, json_file):
    # Load the input JSON file to a dictionary
    with open(json_file) as f:
        data = json.load(f)

    # Extract the relevant fields from the resources list
    rows = []
    for resource in data['resources']:
        resource_type = resource['type']
        for instance in resource['instances']:
            instance_id = instance['attributes']['id']
            attributes = instance['attributes']
            row = [resource_type, instance_id, json.dumps(attributes)]
            rows.append(row)

    # Create a new Excel workbook
    workbook = Workbook()

    # Select the active sheet
    sheet = workbook.active

    # Set the header row bold
    header_font = Font(bold=True)
    sheet.append(['Resource Type', 'ID'])
    for cell in sheet[1]:
        cell.font = header_font

    # Write the rows to the sheet
    for row in rows:
        sheet.append(row)

    # Set the popover for each id cell
    for i, row in enumerate(rows):
        id_cell = sheet.cell(i+2, 2)
        attributes = json.loads(row[2])
        popover = '\n'.join([f'{k}: {v}' for k, v in attributes.items()])
        comment = Comment(popover, 'Details')
        id_cell.comment = comment

    # Save the workbook
    workbook.save(output_file)

if __name__ == '__main__':
    main()
