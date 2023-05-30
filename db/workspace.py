# workspace.py

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
from db.models import Workspace
import os

# Load environment variables from .env file
load_dotenv()

# Get DATABASE_URL from environment variable
DATABASE_URL = os.environ["DATABASE_URL"]

engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)


def update_workspace_terraform_plan(workspace_id, terraform_plan, sacanned_terraform_plan):
    session = Session()

    # Get the existing workspace
    workspace = session.query(Workspace).get(workspace_id)

    if workspace is not None:
        # Update terraformPlan field
        workspace.terraformPlan = terraform_plan
        workspace.scannedTerraformPlan = sacanned_terraform_plan

        # Commit the changes
        session.commit()
    else:
        print(f"No workspace found with ID {workspace_id}")

    # Close the session
    session.close()
