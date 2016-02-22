# Docker Registry v2 UI
## Sequence
This docker image acts also as reverse proxy for the docker registry due to the CORS headers we need to set. 
```sequence
Browser->r2ui: GET http://r2ui/
r2ui->Browser: r2ui UI
Browser->r2ui: GET http://r2ui/v2/_catalog
r2ui->registry: GET http://registryalias:5000/v2/_catalog
registry->r2ui: repositories[]
r2ui->Browser: CORS header & repositories[]
Browser->r2ui: GET http://r2ui/v2/repo/image/tags/list
r2ui->registry:  GET http://registryalias:5000/v2/repository/tags/list
registry->r2ui: tags[]
r2ui->Browser: tags[]
```
# Usage
Docker-compose 1.6 sample excerpt using the mandatory alias name "registryalias":
```
version: '2'

services:
    r2ui:
        image: serverking/r2ui
        ports:
            - "8000:80"
        links:
            - registry:registryalias
        restart: always
    
    registry:
        image: registry:2.3
        volumes:
            - ./registry:/var/lib/registry
        ports:
            - "5000:5000"
        restart: always
```
