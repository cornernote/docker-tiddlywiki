# Supervisor Configuration

Copy the supervisor configuration from the image.

```shell
mkdir build
docker compose cp tiddlywiki:/etc/supervisor/supervisord.conf build/supervisord.conf
```

Change as desired, then update your application definition.

`cat > docker-compose.yml` (paste from below, the `CTRL+D`)


```yaml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki
    volumes:
      - ./build/supervisord.conf:/etc/supervisor/supervisord.conf
    ports:
      - "80:80"
```

Then restart the container.

```shell
docker compose up -d
```