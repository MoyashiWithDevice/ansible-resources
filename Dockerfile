FROM python:3.11-alpine

# パッケージインストール
RUN apk add --no-cache \
    openssh-client \
    git \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    shadow  # useraddで必要

# ansible ユーザー作成
RUN addgroup -g 1500 ansible && adduser -D -u 1500 -G ansible ansible

# ansible ユーザーの .ssh ディレクトリ準備
RUN mkdir -p /home/ansible/.ssh && \
    chown -R ansible:ansible /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh

# Ansible インストール
RUN pip install --no-cache-dir ansible

# 作業ディレクトリ
WORKDIR /ansible

# ユーザー切替（ここは任意。commandで上書き可能）
USER ansible

CMD ["ansible", "--version"]
