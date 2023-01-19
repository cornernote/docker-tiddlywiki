# Docker Image for Tiddlywiki

The image provides tiddlywiki and related services.

[![Pulls](https://img.shields.io/docker/pulls/cornernote/tiddlywiki.svg?style=flat-square)](https://hub.docker.com/r/cornernote/tiddlywiki/)


## Features

- [Tiddlywiki](https://tiddlywiki.com/) - The most awesome way to keep notes.
- [TW5-Bob](https://github.com/OokTech/TW5-Bob) - Provides real-time and multi-user using web sockets.
- [Nginx](https://www.nginx.com/) - Reverse proxy for:
  - [Basic Authentication](docs/basic-authentication.md)
  - [HTTPS/SSL Certificates](docs/ssl-installation.md)


## Installation


### Quick Start

```shell
docker run -p 80:80 cornernote/tiddlywiki
```

Now access your tiddlywiki from [http://localhost/](http://localhost/). 

### Using Docker Compose

Docker compose allows you to keep all the configuration for the docker image in a single file, then run using `docker compose up`.  For most of the guides in documentation the `docker compose` method will be used, however you can always apply the same options just using `docker` commands.

`mkdir tiddlywiki && cat > docker-compose.yml` (paste from below, then `CTRL+D`)

```yaml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki:5.2.3-bob-1.7.3b1
    volumes:
      - ./tiddlywiki:/app
    ports:
      - "80:80"
```

Then start the container

```shell
docker compose up -d
```

For more examples see [Documentation](docs/README.md) > [Examples](docs/examples/README.md).


## Services Provided

The image provides several services to run a multi-user tiddlywiki server.

- [Tiddlywiki NodeJS](https://tiddlywiki.com/static/TiddlyWiki%2520on%2520Node.js.html) - providing the core of the system
- [TW5-Bob](https://github.com/OokTech/TW5-Bob) - a plugin that makes tiddlywiki a multi-user wiki on node
- [Nginx](https://nginx.com) - high-performance HTTP server and reverse proxy
- [Supervisor](http://supervisord.org/) - allows multiple processes to run within a single container


## Supported Tags

- `latest`
- `5.2.3-bob-1.7.3b1`


## Resources

* [GitHub Project](https://github.com/cornernote/docker-tiddlywiki)
* [DockerHub Project](https://hub.docker.com/r/cornernote/tiddlywiki/)
