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
