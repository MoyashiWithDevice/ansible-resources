# 軽量な Python イメージをベースに使用
FROM python:3.11-alpine

# 1. 必要なパッケージのインストール
# openssh-client: リモート接続用
# sshpass: パスワード認証が必要な場合用 (オプション)
# git: Playbook取得用 (今回は initContainer で行っていますが、あると便利)
RUN apk add --no-cache \
    openssh-client \
    git \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev

# 2. Ansible のインストール
RUN pip install --no-cache-dir ansible

# 3. 作業ディレクトリの設定
WORKDIR /ansible

# 4. SSH の設定 (Known Hosts チェックの無効化など)
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# デフォルトのコマンド (Job側で上書き可能)
CMD ["ansible", "--version"]