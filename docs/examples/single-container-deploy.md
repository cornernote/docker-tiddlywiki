# Single Container Deploy

Run all the services in a single container. This is the default configuration.

## Configuration

No configuration is needed, however if you want to run other services you can copy the `supervisor.conf` to your local system for modification, then mount it back onto the image.

```shell
mkdir build
docker cp root_tiddlywiki_1:/etc/supervisord/supervisord.conf build/supervisord.conf
```

Update your application definition.

`cat > docker-compose.yml` (paste from below, the `CTRL+D`)

```yaml
version: '3'
services:
  php:
    image: cornernote/tiddlywiki
    volumes:
      - ./tiddlywiki:/app
      - ./build/supervisord.conf:/etc/supervisor/supervisord.conf
    ports:
      - "80:80"
```
