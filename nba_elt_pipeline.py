from logging.config import _LoggerConfiguration
import os

from prefect import flow, task
from prefect.task_runners import DaskTaskRunner
from prefect.tasks.shell import ShellTask
from prefect.run_configs import ECSRun
from typing import List

from utils import get_ssm_parameter

jacobs_network_config = {
    "awsvpcConfiguration": {
        "securityGroups": [get_ssm_parameter("jacobs_ssm_sg_task")],
        "subnets": [
            get_ssm_parameter("jacobs_ssm_subnet1"),
            get_ssm_parameter("jacobs_ssm_subnet2"),
        ],
        "assignPublicIp": "ENABLED",
    }
}

os.environ["AWS_DEFAULT_REGION"] = "us-east-1"
DBT_PROFILE_DIR = "~/.dbt/"
DBT_PROJECT_DIR = "~/dbt/"


# https://docs.prefect.io/api/latest/run_configs.html#ecsrun
# idfk dude, looks like there needs to be prefect-specific parameters like the container needs to be named "flow" ???
# the task definition created with terraform already has the roles 
@task
def web_scrape_job():
    print('web scrape script')
    return ECSRun(
        labels=["dev", "nba_elt_pipeline", "web_scrape"],
        task_definition=dict(
            family="jacobs_task",
            requiresCompatibilities=["FARGATE"],
            networkMode="awsvpc",
            cpu=1024,
            memory=2048,
            taskRoleArn=f"arn:aws:iam::{ACCOUNT_ID}:role/prefectTaskRole",
            executionRoleArn=f"arn:aws:iam::{ACCOUNT_ID}:role/prefectECSAgentTaskExecutionRole",
            containerDefinitions=[
                dict(
                    name="flow",
                    image=f"{ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/your_image_name:latest",
                    run_type="dev",
                    RDS_SCHEMA="nba_source_dev",
                )
            ],
        ),
        run_task_kwargs=dict(cluster="prefectEcsCluster"),
    )

@task
def dbt_build():
    return(ShellTask(command = f"dbt build--profiles-dir {DBT_PROFILE_DIR} --project-dir {DBT_PROJECT_DIR}"))


@task
def ml_pipeline_job():
    print('ml pipeline build')
    return ECSRun(
        labels=["dev", "nba_elt_pipeline", "ml"],
        task_definition=dict(
            family="jacobs_task",
            requiresCompatibilities=["FARGATE"],
            networkMode="awsvpc",
            cpu=1024,
            memory=2048,
            taskRoleArn=f"arn:aws:iam::{ACCOUNT_ID}:role/prefectTaskRole",
            executionRoleArn=f"arn:aws:iam::{ACCOUNT_ID}:role/prefectECSAgentTaskExecutionRole",
            containerDefinitions=[
                dict(
                    name="flow",
                    image=f"{ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/your_image_name:latest",
                    run_type="dev",
                    RDS_SCHEMA="nba_source_dev",
                )
            ],
        ),
        run_task_kwargs=dict(cluster="prefectEcsCluster"),
)

@task
def pipeline_confirmation_email():
    print('pipeline confirmation email')

@flow(name="NBA_ELT_PIPELINE_DEV", task_runner=DaskTaskRunner())
def nba_elt_pipeline_flow():
    web_scrape_job()
    dbt_build()
    ml_pipeline_job()
    pipeline_confirmation_email()
    return 1

# run the flow!
if __name__ == "__main__":
    nba_elt_pipeline_flow()