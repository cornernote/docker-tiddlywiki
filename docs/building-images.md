# Building Images

## Build Image

```shell
docker compose build --no-cache
```

## Tag Image:

Use `docker images` to get the Image ID, for example `4905859521ec`.


```shell
docker tag 5882a680a4f6 cornernote/tiddlywiki:latest
docker tag 5882a680a4f6 cornernote/tiddlywiki:5.2.3-bob-1.7.1
```

## Push Image

Push to hub.docker.com

```shell
docker push cornernote/tiddlywiki:latest
docker push cornernote/tiddlywiki:5.2.3-bob-1.7.1
```

## Shell into image

If something went wrong.

```shell
docker compose run --rm tiddlywiki sh
```