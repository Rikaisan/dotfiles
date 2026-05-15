function dockerrmi
    docker images | tail +2 | awk "\$1 == \"$argv[1]\" {print \$3}" | xargs -r docker rmi -f
end