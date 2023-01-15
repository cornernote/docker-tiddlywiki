# Docker Image for Tiddlywiki

The image provides tiddlywiki and related services.

[![Pulls](https://img.shields.io/docker/pulls/cornernote/tiddlywiki.svg?style=flat-square)](https://hub.docker.com/r/cornernote/tiddlywiki/)

## Documentation

### Quick Start

`cat > docker-compose.yml` (paste from below, then `CTRL+D`)

```yaml
version: '3'
services:
  php:
    image: cornernote/tiddlywiki
    volumes:
      - ./tiddlywiki:/app
    ports:
      - "80:80"
```

Then start the container

```shell
docker compose up -d
```

Now access your tiddlywiki from [http://localhost/](http://localhost/).  The user/pass is `admin`/`admin`.

For more examples see [Documentation](docs/README.md) > [Examples](docs/examples/README.md).


## Services Provided

The image provides several services to run a multi-user tiddlywiki server.

### Tiddlywiki

Tiddlywiki NodeJS.  This is the core of the system.

### TW5-Bob

TW5-Bob is a multi-user plugin for Tiddlywiki.

### Nginx

Nginx is a high-performance HTTP server and reverse proxy.

SSL certificate support for letsencrypt with certbot.

Basic authentication can be configured via a `.htpasswd` file.

The nginx service is available on port 80 and 443.

### Supervisor

Supervisor is a system that allows monitoring and control a number of processes.

Docker runs a single service. Supervisor allows multiple processes to run within a single container.


## Supported tags and `Dockerfile` links

### `latest` [Dockerfile](https://github.com/cornernote/docker-tiddlywiki/blob/main/Dockerfile)


## Resources

* [GitHub Project](https://github.com/cornernote/docker-tiddlywiki)
* [DockerHub Project](https://hub.docker.com/r/cornernote/tiddlywiki/)