# Building Images

## Build Image

```shell
docker compose build --no-cache
```

## Tag Image:

Use `docker images` to get the Image ID, for example `4905859521ec`.


```shell
docker tag 4905859521ec cornernote/tiddlywiki:latest
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