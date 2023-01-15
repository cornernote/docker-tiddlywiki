# Building Images

## Build Image

```shell
docker compose build
```

This will show a TagID, for example `aa870edc0261`.

## Tag Image:

```shell
docker tag aa870edc0261 cornernote/tiddlywiki:latest
```

## Push Image

Push to hub.docker.com

```shell
docker push cornernote/tiddlywiki:latest
```

## Shell into image

If something went wrong.

```shell
docker compose run --rm tiddlywiki sh
```