# Building Images

## Build Image

```shell
docker compose build --no-cache
```

## Tag Image:

Use `docker images` to get the Image ID, for example `3264a40419ae`.


```shell
docker tag 3264a40419ae cornernote/tiddlywiki:latest
docker tag 3264a40419ae cornernote/tiddlywiki:5.2.5-bob-1.7.3b1
```

## Push Image

Push to hub.docker.com

```shell
docker push cornernote/tiddlywiki:latest
docker push cornernote/tiddlywiki:5.2.5-bob-1.7.3b1
```

## Shell into image

If something went wrong.

```shell
docker compose run --rm tiddlywiki sh
```