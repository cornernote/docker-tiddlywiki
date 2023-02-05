# Custom Plugins

Copy the `plugins/` folder from the docker image

```sh
docker compose cp tiddlywiki:/usr/local/tiddlywiki/plugins plugins
```

Mount the `plugins/` folder to the docker image

```yml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki
    volumes:
      - ./tiddlywiki:/app
      - ./plugins:/usr/local/tiddlywiki/plugins
    ports:
      - "80:80"
```