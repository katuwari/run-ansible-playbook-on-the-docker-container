# Create docker container to run ansible playbook 
This mini project creates a Docker container that is ready to run Ansible playbooks

## Gears

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

WORKDIR /workspace/gs
```

## Docker Setup

### Build docker image
Need to build the docker image by the following command
```c
❯ docker build -t ansible .
```
once the image build, it can be verified by "docker image ls <image name>"
<img width="520" height="62" alt="image" src="https://github.com/user-attachments/assets/0ee899a3-3484-40ee-b161-dd3dd72778c8" />

### Run docker container
In this runtime, mounted a volume to the container which is consist of the ansible structure folder on the host machine and also mounted an ansible-galaxy that required
```c
docker run -dit \
  --name ansible \
  -v ~/path/to/ansible/structure/folder/on/the/host:/workspace/gs \
  -v /path/to/.ansible:/root/.ansible \
  ansible \
  bash
```
once done, it can be verified by "docker ps"
<img width="731" height="63" alt="image" src="https://github.com/user-attachments/assets/0de0a8bf-5f87-4a40-a909-273b169073dc" />

### Docker exec 
<img width="736" height="101" alt="image" src="https://github.com/user-attachments/assets/75742517-8d16-42fc-ae7b-c1068d0c8f5d" />
shown that the ansible structure has mounted to the container so we might run the ansible-playbook

<img width="1270" height="658" alt="image" src="https://github.com/user-attachments/assets/a9f5f722-c2fa-42df-80fe-5eac5add5681" />
