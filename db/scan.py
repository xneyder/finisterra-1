import os
from datetime import datetime
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, joinedload
from sqlalchemy.dialects.postgresql import insert
from db.models import Scan, Workspace, ProviderGroup, Base


# Load environment variables from .env file
load_dotenv()

# Get DATABASE_URL from environment variable
DATABASE_URL = os.environ["DATABASE_URL"]

engine = create_engine(DATABASE_URL)
Base.metadata.bind = engine

Session = sessionmaker(bind=engine)


def upsert_scan(organization_id, workspace_id, date, status, trigger, log_file):
    session = Session()
    current_time = datetime.utcnow()

    # Prepare the upsert statement
    stmt = insert(Scan).values(
        organizationId=organization_id,
        workspaceId=workspace_id,
        date=date,
        status=status,
        trigger=trigger,
        logFile=log_file,
        createdAt=current_time,
        updatedAt=current_time
    ).on_conflict_do_update(
        index_elements=['workspaceId'],
        set_=dict(
            organizationId=organization_id,
            date=date,
            status=status,
            trigger=trigger,
            logFile=log_file,
            updatedAt=current_time
        )
    )

    # Execute the upsert statement
    session.execute(stmt)

    # Commit the transaction
    session.commit()

    # Close the session
    session.close()


def get_scan_by_id(scan_id):
    session = Session()

    try:
        # Query the scan by ID and eagerly load the related 'workspace', 'organization', 'awsAccount' and 'providerGroup'
        scan = session.query(Scan).options(
            joinedload(Scan.workspace).joinedload(Workspace.awsAccount),
            joinedload(Scan.workspace).joinedload(Workspace.providerGroup),
            joinedload(Scan.organization)
        ).get(scan_id)

        return scan
    finally:
        # Close the session
        session.close()
