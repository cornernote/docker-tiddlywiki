# SSL Installation

## Using `certbot`

Create a `cornernote/docker-tiddlywiki` application definition:

`cat > docker-compose.yml` (paste from below, then `CTRL+D`)

```yaml
version: '3'
services:
  php:
    image: cornernote/tiddlywiki
    ports:
      - "80:80"
      - "443:443"
```

Start the container

```shell
docker compose up -d
```

Request the certificate by running `certbot` inside the container.

```shell
docker compose exec tiddlywiki certbot certonly \
    --noninteractive \
    --agree-tos \
    --email info@example.com \
    --webroot --webroot-path /var/letsencrypt \
    -d example.com
```

Alter your `nginx.conf`.

```shell
TODO
```

Restart the container

```shell
docker compose up -d && docker compose restart
```

## Manual Installation

You can easily map your existing SSL certificate into the container.

Create a `cornernote/docker-tiddlywiki` application definition:

`cat > docker-compose.yml` (paste from below, then `CTRL+D`)

```yaml
version: '3'
services:
  php:
    image: cornernote/tiddlywiki
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./build/ssl/key.pem:/etc/letsencrypt/live/example.com/privkey.pem
      - ./build/ssl/cert.pem:/etc/letsencrypt/live/example.com/fullchain.pem
      - ./build/ssl/cert.pem:/etc/letsencrypt/live/example.com/chain.pem
```

Create a self-signed SSL certificate

```shell script
mkdir -p build/ssl && openssl req -x509 -newkey rsa:4096 -keyout build/ssl/key.pem -out build/ssl/cert.pem -days 365
```

Start the container

```shell script
docker compose up -d
```
