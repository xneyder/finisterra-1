from sqlalchemy.orm import joinedload
import os
from datetime import datetime
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, joinedload
from sqlalchemy.dialects.postgresql import insert
from db.models import Run, Workspace, ProviderGroup, AwsAccount, AwsAccountGitRepo, GitRepo, Base


# Load environment variables from .env file
load_dotenv()

# Get DATABASE_URL from environment variable
DATABASE_URL = os.environ["DATABASE_URL"]

engine = create_engine(DATABASE_URL)
Base.metadata.bind = engine

Session = sessionmaker(bind=engine)


def update_run_status(run_id, status):
    session = Session()
    current_time = datetime.utcnow()

    # Get the existing run
    run = session.query(Run).get(run_id)

    if run is not None:
        # Update status and updatedAt
        run.status = status
        run.updatedAt = current_time

        # Commit the changes
        session.commit()
    else:
        print(f"No run found with ID {run_id}")

    # Close the session
    session.close()


def get_run_by_id(run_id):
    session = Session()

    try:
        # Query the run by ID and eagerly load the related 'workspace', 'organization', 'awsAccount', 'awsAccountGitRepos', 'gitRepo', 'githubAccount', and 'providerGroup'
        run = session.query(Run).options(
            joinedload(Run.workspace).joinedload(Workspace.awsAccount).joinedload(
                AwsAccount.awsAccountGitRepos).joinedload(AwsAccountGitRepo.gitRepo).joinedload(GitRepo.githubAccount),
            joinedload(Run.workspace).joinedload(Workspace.providerGroup),
            joinedload(Run.organization),
            joinedload(Run.workspace).joinedload(
                Workspace.awsAccount).joinedload(AwsAccount.awsStateConfigs)
        ).get(run_id)

        return run
    finally:
        # Close the session
        session.close()
