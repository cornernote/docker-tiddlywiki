# Multiple Container Deploy

Run multiple containers, one for each service. 

Copy the nginx configuration from the image.

```shell
mkdir build
docker cp root_tiddlywiki_1:/etc/nginx/http.d/default.conf build/nginx.conf
```

Change the websocket to point to the `tiddlywiki` host.

```
upstream websocket {
    server tiddlywiki:8080;
}
```

Update your application definition.

`cat > docker-compose.yml` (paste from below, the `CTRL+D`)

```yaml
version: '3'
services:

  tiddlywiki:
    image: cornernote/tiddlywiki
    entrypoint: run-tiddlywiki.sh
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

Change the bob wiki settings `ws-server.host` to `0.0.0.0` as follows:

```shell
  "ws-server": {
    ...
    "host": "0.0.0.0",
    ...
  }
```