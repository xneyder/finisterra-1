import click
import os
import json
import gspread
from google.oauth2 import service_account
from googleapiclient.discovery import build
from gspread_formatting import *

@click.command()
@click.option('--credentials-file', '-c', required=True, type=click.Path(exists=True), help='Path to the Google Sheets API credentials JSON file.')
@click.option('--spreadsheet-id', '-s', required=True, help='Google Sheets spreadsheet ID.')
@click.argument('json-file', type=click.Path(exists=True))
def main(credentials_file, spreadsheet_id, json_file):
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

    # Authenticate with the Google Sheets API using a service account
    creds = service_account.Credentials.from_service_account_file(credentials_file, scopes=['https://www.googleapis.com/auth/spreadsheets'])

    # Build the Google Sheets API service
    service = build('sheets', 'v4', credentials=creds)

    # Define the sheet name and range
    sheet_name = 'Sheet1'
    sheet_range = f'{sheet_name}!A1:C{len(rows)+1}'

    # Update the sheet with the rows
    result = service.spreadsheets().values().update(spreadsheetId=spreadsheet_id, range=sheet_range, valueInputOption='USER_ENTERED', body={'values': rows}).execute()

    print(f'{result["updatedCells"]} cells updated.')

    # Authorize gspread
    client = gspread.authorize(creds)

    # Open the sheet
    sheet = client.open_by_key(spreadsheet_id).worksheet(sheet_name)

    # Set the header row bold
    # format_cell_range(sheet, 'A1:C1', {'textFormat': {'bold': True}})

    # Set the popover for each id cell
    for i, row in enumerate(rows):
        id_cell = sheet.cell(i+2, 2)
        attributes = json.loads(row[2])
        popover = '\n'.join([f'{k}: {v}' for k, v in attributes.items()])
        id_cell.note = popover
        sheet.update_cell(i+2, 2, id_cell.value)

if __name__ == '__main__':
    main()
