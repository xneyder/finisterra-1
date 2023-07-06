import os
from datetime import datetime
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, joinedload
from sqlalchemy.dialects.postgresql import insert
from db.models import TerraformModuleInstance, TerraformModule,  Base


# Load environment variables from .env file
load_dotenv()

# Get DATABASE_URL from environment variable
DATABASE_URL = os.environ["DATABASE_URL"]

engine = create_engine(DATABASE_URL)
Base.metadata.bind = engine

Session = sessionmaker(bind=engine)


def get_module_data(workspace_id):
    session = Session()
    try:
        instances = session.query(TerraformModuleInstance).filter_by(
            workspaceId=workspace_id).all()

        if not instances:
            return {}

        result = {}
        for instance in instances:
            key = f"{instance.resource_type}_{instance.resource_name}"
            result[key] = {
                'module_instance': instance.module_instance,
                'module_name': instance.terraform_module.name
            }

        return result

    except Exception as e:
        print(f"An error occurred: {e}")
        return None

    finally:
        session.close()


def get_terraform_modules_by_workspace_id(workspace_id):

    session = Session()
    try:
        modules = session.query(TerraformModule).\
            join(TerraformModuleInstance, TerraformModule.id == TerraformModuleInstance.TerraformModuleId).\
            filter(TerraformModuleInstance.workspaceId == workspace_id).all()

        return modules

    except Exception as e:
        print(f"An error occurred: {e}")
        return None

    finally:
        session.close()
