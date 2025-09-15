docker-compose down
docker rm -f registry || true
docker volume rm devops_pgdata || true
