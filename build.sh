#!/bin/sh -e

# Slave container to execute the build
docker build -t 'node-slave' -f components/node-slave/Dockerfile components/node-slave/
docker run --rm \
    -v $PWD:/app \
    -v $PWD/components/r2ui/src/usr/share/nginx/html/:/app/dist \
    -w /app \
    -t node-slave \
    /bin/sh -c "npm install && \
        bower --allow-root --config.interactive=false install && \
        grunt"
