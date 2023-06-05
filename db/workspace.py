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


def update_workspace(workspace_id, terraform_plan, scannedTerraformPlan, terraformPlanBranch2Main, drift_fix_pr):
    session = Session()

    # Get the existing workspace
    workspace = session.query(Workspace).get(workspace_id)

    if workspace is not None:
        # Update terraformPlan field
        workspace.terraformPlan = terraform_plan
        workspace.scannedTerraformPlan = scannedTerraformPlan
        workspace.terraformPlanBranch2Main = terraformPlanBranch2Main
        workspace.driftFixPR = drift_fix_pr

        # Commit the changes
        session.commit()
    else:
        print(f"No workspace found with ID {workspace_id}")

    # Close the session
    session.close()
