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
