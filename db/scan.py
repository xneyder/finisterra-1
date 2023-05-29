from sqlalchemy.orm import joinedload
import os
from datetime import datetime
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, joinedload
from sqlalchemy.dialects.postgresql import insert
from db.models import Scan, Workspace, ProviderGroup, AwsAccount, AwsAccountGitRepo, GitRepo, Base


# Load environment variables from .env file
load_dotenv()

# Get DATABASE_URL from environment variable
DATABASE_URL = os.environ["DATABASE_URL"]

engine = create_engine(DATABASE_URL)
Base.metadata.bind = engine

Session = sessionmaker(bind=engine)


def update_scan_status(scan_id, status):
    session = Session()
    current_time = datetime.utcnow()

    # Get the existing scan
    scan = session.query(Scan).get(scan_id)

    if scan is not None:
        # Update status and updatedAt
        scan.status = status
        scan.updatedAt = current_time

        # Commit the changes
        session.commit()
    else:
        print(f"No scan found with ID {scan_id}")

    # Close the session
    session.close()


def get_scan_by_id(scan_id):
    session = Session()

    try:
        # Query the scan by ID and eagerly load the related 'workspace', 'organization', 'awsAccount', 'awsAccountGitRepos', 'gitRepo', 'githubAccount', and 'providerGroup'
        scan = session.query(Scan).options(
            joinedload(Scan.workspace).joinedload(Workspace.awsAccount).joinedload(
                AwsAccount.awsAccountGitRepos).joinedload(AwsAccountGitRepo.gitRepo).joinedload(GitRepo.githubAccount),
            joinedload(Scan.workspace).joinedload(Workspace.providerGroup),
            joinedload(Scan.organization),
            joinedload(Scan.workspace).joinedload(
                Workspace.awsAccount).joinedload(AwsAccount.awsStateConfigs)
        ).get(scan_id)

        return scan
    finally:
        # Close the session
        session.close()
