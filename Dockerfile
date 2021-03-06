FROM alpine:latest

RUN apk add --update nginx && rm -rf /var/cache/apk/*

ADD src /

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


