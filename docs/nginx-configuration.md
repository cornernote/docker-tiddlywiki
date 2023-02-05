# Nginx Configuration

Copy the nginx configuration from the image.

```shell
mkdir build
docker compose cp tiddlywiki:/etc/nginx/http.d/default.conf build/nginx.conf
```

Change as desired, then update your `docker-compose.yml`.

```yaml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki
    volumes:
      - ./tiddlywiki:/app
      - ./build/nginx.conf:/etc/nginx/http.d/default.conf
    ports:
      - "80:80"
```

Then restart the container.

```shell
docker compose up -d
```