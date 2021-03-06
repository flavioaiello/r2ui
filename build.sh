#!/bin/sh -e

# Slave container to execute the build
docker build -t 'node-slave' -f build/Dockerfile build
docker run --rm \
    -v $PWD/build:/app \
    -v $PWD/src/usr/share/nginx/html/:/app/dist \
    -w /app \
    -t node-slave \
    /bin/sh -c "npm install && \
        bower --allow-root --config.interactive=false install && \
        grunt"
