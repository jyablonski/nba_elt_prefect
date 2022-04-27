# Agents
Agents are where the Flows RUN.  `ECSAgent` would run in AWS ECS.  `LocalAgent` would run on your local computer.  `DockerAgent` would run in Docker.

For testing purposes I think it makes sense to stick with `LocalAgent`, and either run flows on personal pc or on an EC2 server.  Sticking it on ECS is expensive.


https://rdrn.me/scaling-out-prefect/
https://www.lejimmy.com/distributed-data-pipelines-with-aws-ecs-fargate-and-prefect-cloud/

`prefect config set PREFECT_API_URL="https://api-beta.prefect.io/api/accounts/d9852c4a-8c7f-474a-bb57-9f97d48212f5/workspaces/4588a7e7-df60-45df-a0fd-c1a0173b763d"`
# Executors
Use Dask executor on local machine, it will basically just try to use as many resources as possible to run the workflow.