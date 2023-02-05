# Basic Authentication

Copy the nginx configuration from the image.

```shell
mkdir build
docker compose cp tiddlywiki:/etc/nginx/http.d/default.conf build/nginx.conf
```

Add the following to the `location / { ... }` section. 

```
    location / {
        ...
        auth_basic "Login";
        auth_basic_user_file /etc/nginx/.htpasswd;
        proxy_set_header X-Authenticated-User $remote_user;
    }
```

You can create a `.htpasswd` file as follows:

```shell
mkdir build
htpasswd -c build/.htpasswd yourusername 
```

Add users later:

```shell
htpasswd build/.htpasswd anotherusername 
```

Mount your `nginx.conf` and `.htpasswd` file into the container by adding the volume to your `docker-compose.yml`.

```yaml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki
    volumes:
      - ./tiddlywiki:/app
      - ./build/nginx.conf:/etc/nginx/http.d/default.conf
      - ./build/.htpasswd:/etc/nginx/.htpasswd
    ports:
      - "80:80"
```

Then restart the container.

```shell
docker compose up -d
```

## Notes

This does not show the user as logged into Tiddlywiki.  Changes to tiddlers will still be from an empty username.

To fix this please see [User Authentication](user-authentication.md).