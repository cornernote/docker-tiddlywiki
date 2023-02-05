# Multiple Container Deploy

Run multiple containers, one for each service. 

Copy the nginx configuration from the image.

```shell
mkdir build
docker compose cp tiddlywiki:/etc/nginx/http.d/default.conf build/nginx.conf
```

Change the websocket to point to the `tiddlywiki` host.

```
upstream websocket {
    server tiddlywiki:8080;
}
```

Update your `docker-compose.yml` 

```yaml
version: '3'
services:

  tiddlywiki:
    image: cornernote/tiddlywiki
    entrypoint: run-bob.sh
    volumes:
      - ./tiddlywiki:/app

  nginx:
    image: cornernote/tiddlywiki
    entrypoint: run-nginx.sh
    volumes:
      - ./build/nginx.conf:/etc/nginx/http.d/default.conf
    ports:
      - "80:80"
```
