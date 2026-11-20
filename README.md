# 環境構築

# Rootful Docker

通常はこちら．docker 内に一般ユーザーを作成

1. Dockerfile, docker-compose.yaml をマウントしたいディレクトリ直下へコピー
2. 以下を実行

```bash
# 自分の UID/GID を .env に出力
printf "UID=%s\nGID=%s\n" $(id -u) $(id -g) > .env
cat .env

# コンテナ起動
docker compose up -d --build

# コンテナに入る
docker exec -it kino-dev zsh
```

# Rootless Docker

rootless docker の場合はこちら．コンテナ内 root がホストの自分に対応するので，docker 内では root のまま使う

1. Dockerfile, docker-compose.yaml をマウントしたいディレクトリ直下へコピー
2. 以下を実行

```bash
# コンテナ起動
docker compose up -d --build

# コンテナに入る
docker exec -it kino-dev zsh
```

## GPU を使うための準備 (初回のみ)

NVIDIA Container Toolkit がインストール済みの前提 (`sudo apt install nvidia-container-toolkit`)

```bash
# rootless 用の設定
nvidia-ctk runtime configure --runtime=docker --config=$HOME/.config/docker/daemon.json
sudo nvidia-ctk config --set nvidia-container-cli.no-cgroups --in-place

# CDI の設定ファイルを作成 (ドライバ更新後も再実行)
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml

# rootless docker を再起動
systemctl --user restart docker

# 確認
docker run --rm --gpus all ubuntu nvidia-smi
```
