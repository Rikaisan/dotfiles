function docker-logs
    docker ps --format '{{.Names}}' | fzf | docker logs -f
end