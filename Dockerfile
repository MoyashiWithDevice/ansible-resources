FROM python:3.11-slim

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client \
    git \
    gcc \
    build-essential \
    libffi-dev \
    libssl-dev \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ansible ユーザー作成（UID/GID を 1500 に固定）
RUN groupadd -g 1500 ansible && useradd -m -u 1500 -g ansible ansible

# .ssh ディレクトリ準備
RUN mkdir -p /home/ansible/.ssh && \
    chown -R ansible:ansible /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh

# Ansible インストール
RUN pip install --no-cache-dir ansible

# 作業ディレクトリ
WORKDIR /ansible

# ユーザー切り替え
USER ansible

# デフォルトコマンド
CMD ["ansible", "--version"]
