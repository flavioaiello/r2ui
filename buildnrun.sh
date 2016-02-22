#!/bin/sh -e

#docker rm -f $(docker ps -aq)

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

# Start registry
docker run --name registry -p 5000:5000 -d registry:2.3

# Build runtime container
docker build -t localhost:5000/serverking/r2ui:latest -f components/r2ui/Dockerfile components/r2ui/

# Push runtime container to registry
docker push localhost:5000/serverking/r2ui:latest

# Create and run new r2ui container
docker run -d -p 8000:80 --link registry:registryalias localhost:5000/serverking/r2ui:latest

docker ps

