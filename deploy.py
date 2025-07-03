import logging
from truefoundry.deploy import (
    Build,
    NodeSelector,
    DockerFileBuild,
    LocalSource,
    Service,
    Resources,
    Port,
)

logging.basicConfig(level=logging.INFO)

service = Service(
    name="agrikart-bd",
    image=Build(
        build_source=LocalSource(),
        build_spec=DockerFileBuild(
            dockerfile_path="./Dockerfile", build_context_path="./"
        ),
    ),
    resources=Resources(
        cpu_request=0.5,
        cpu_limit=0.5,
        memory_request=1000,
        memory_limit=1000,
        ephemeral_storage_request=500,
        ephemeral_storage_limit=500,
        node=NodeSelector(),
    ),
    env={"KEY": "VALUE"},
    ports=[
        Port(
            port=8000,
            protocol="TCP",
            expose=True,
            app_protocol="http",
            host="agrikart-bd-ws-2a-8000.ml.iit-ropar.truefoundry.cloud",
        )
    ],
    replicas=1.0,
    labels={
        "tfy.dev/auto-shutdown": "enabled"  # <-- Enable auto-shutdown
    }
)

service.deploy(workspace_fqn="tfy-iitr-az:demo", wait=False)
