# Run docker container to run ansible playbook 
This mini project creates a Docker container that is ready to run Ansible playbooks

## Setup

### Docker

- Docker version 26.1.5
- Base Image https://hub.docker.com/hardened-images/catalog/dhi/debian-base

### Ansible

- Ansible-core==2.13.13 (This version is suitable for network automation since it still support paramiko connection)

### Dockerfile
In this dockerfile, defined the needed tools installation
```c
FROM dhi.io/debian-base:trixie-debian13-dev

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        git \
        ssh \
        vim \
        iputils-ping \
        netcat-openbsd \
        ca-certificates \
 && python3 -m venv /opt/ansible \
 && /opt/ansible/bin/pip install --upgrade pip \
 && /opt/ansible/bin/pip install \
        ansible-core==2.13.13 \
        paramiko \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/ansible/bin:$PATH"

WORKDIR /workspace
```

## Docker runtime
In this runtime, mounted a volume to the container which is consist of the ansible structure folder on the host machine and also mounted an ansible-galaxy that required
```c
docker run -dit \
  --name ansible \
  -v ~/path/to/ansible/structure/folder/on/the/host:/workspace \
  -v /path/to/.ansible:/root/.ansible \
  ansible \
  bash
```

once the image build, it can be verified by "docker image ls <image name>"
<img width="520" height="62" alt="image" src="https://github.com/user-attachments/assets/0ee899a3-3484-40ee-b161-dd3dd72778c8" />
