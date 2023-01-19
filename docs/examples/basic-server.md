# Basic Server

Create a `cornernote/docker-tiddlywiki` application definition:

`cat > docker-compose.yml` (paste from below, then `CTRL+D`)

```yaml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki
    ports:
      - "80:80"
```

Then start the container

```shell
docker compose up -d
```
