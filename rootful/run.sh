# 自分の UID/GID を .env に出力
printf "UID=%s\nGID=%s\n" $(id -u) $(id -g) > .env
cat .env

# コンテナ起動
docker compose up -d --build

# コンテナに入る
docker exec -it kino-dev zsh