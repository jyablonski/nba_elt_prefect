import prefect
from prefect import task, Flow
from prefect.run_configs import ECSRun


@task
def hello_task():
    logger = prefect.context.get("logger")
    logger.info("Hello world!")

flow = Flow("hello-flow", tasks=[hello_task])

flow.run_config = ECSRun(
    env={"SOME_VAR": "VALUE"},
    image="my-custom-image"
)

# flow.run()

# flow.register(project_name="tester")

# prefect run -p prefect_cloud.py
# python prefect_cloud.py