# Run docker container to run ansible playbook 
This mini project creates a Docker container that is ready to run Ansible playbooks

## Setup

### Docker

- Docker version 26.1.5
- Base Image https://hub.docker.com/hardened-images/catalog/dhi/debian-base

### Ansible

- Ansible-core==2.13.13 (This version is suitable for network automation since it still support paramiko connection)

### Dockerfile

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
