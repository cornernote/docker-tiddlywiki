# SSL Installation

## Using `certbot`

Create a `build/nginx.conf` file with the following:

```
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}
upstream websocket {
    server 127.0.0.1:8080;
}
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
    # certbot challenge
    location ^~ /.well-known/acme-challenge/ {
        root /var/www/_letsencrypt;
    }
    # redirect all requests to https
    location / {
        # set the port if you redirect the https port in docker-compose.yml
        return 301 https://${SERVER_NAME}:443$request_uri;
    }
}
```

Add the `nginx.conf` to your `docker-compose.yml` and expose port `443`. You can optionally map it to another port.

```yaml
version: '3'
services:
  php:
    image: cornernote/tiddlywiki
    volumes:
      - ./build/nginx.conf:/etc/nginx/http.d/default.conf
    ports:
      - "80:80"
      - "443:443"
      #- "8080:80"
      #- "8443:443"
```

Start the container

```shell
docker compose up -d
```

Request the certificate by running `certbot` command inside the container. Replace `info@example.com` and `example.com` with your own details.

```shell
docker compose exec tiddlywiki certbot certonly \
    --noninteractive \
    --agree-tos \
    --email info@example.com \
    --webroot --webroot-path /var/letsencrypt \
    -d example.com
```

Add the SSL configuration to the bottom of your `build/nginx.conf`. Replace `example.com` with your domain name.

```
server {
    listen       443 ssl http2;
    listen  [::]:443 ssl http2;
    server_name  localhost;

    # SSL
    ssl_certificate                      /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key                  /etc/letsencrypt/live/example.com/privkey.pem;
    ssl_trusted_certificate              /etc/letsencrypt/live/example.com/chain.pem;

    # security headers
    add_header X-Frame-Options           "SAMEORIGIN" always;
    add_header X-XSS-Protection          "1; mode=block" always;
    add_header X-Content-Type-Options    "nosniff" always;
    add_header Referrer-Policy           "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy   "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

    location / {
        auth_basic "Login";
        auth_basic_user_file /etc/nginx/.htpasswd;
        proxy_pass http://websocket;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $host;
        proxy_set_header X-Authenticated-User $remote_user;
    }
}
```

Restart the container to reload the nginx configuration.

```shell
docker compose restart
```

## Manual Installation

You can map your existing SSL certificate into the container.

Create a self-signed SSL certificate

```shell
mkdir -p build/ssl && openssl req -x509 -newkey rsa:4096 -keyout build/ssl/tiddlywiki.key -out build/ssl/tiddlywiki.crt -days 365 -nodes
```
Use the entire `build/nginx.conf` from the certbot method above.

Add volumes to `docker-compose.yml` from your local certificate to the container location defined in your `nginx.conf`:


```yaml
version: '3'
services:
  php:
    image: cornernote/tiddlywiki
    volumes:
      - ./build/nginx.conf:/etc/nginx/http.d/default.conf
      - ./build/ssl/tiddlywiki.key:/etc/letsencrypt/live/example.com/privkey.pem
      - ./build/ssl/tiddlywiki.crt:/etc/letsencrypt/live/example.com/fullchain.pem
      - ./build/ssl/tiddlywiki.crt:/etc/letsencrypt/live/example.com/chain.pem
    ports:
      - "80:80"
      - "443:443"
```

Start the container

```shell
docker compose up -d
```
