# Building Images

## Build Image

```shell
docker compose build --no-cache
```

## Tag Image:

Use `docker images` to get the Image ID, for example `4905859521ec`.


```shell
docker tag c5eabb67e4ab cornernote/tiddlywiki:latest
docker tag c5eabb67e4ab cornernote/tiddlywiki:5.2.3-bob-1.7.3b1
```

## Push Image

Push to hub.docker.com

```shell
docker push cornernote/tiddlywiki:latest
docker push cornernote/tiddlywiki:5.2.3-bob-1.7.3b1
```

## Shell into image

If something went wrong.

```shell
docker compose run --rm tiddlywiki sh
```