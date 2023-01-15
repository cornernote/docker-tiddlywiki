# User Management

## Manage User Logins

User access provided via basic-auth via the `/etc/nginx/.htpasswd` file.

The default username and password are `admin`/`admin`.

You can create a `.htpasswd` file as follows:

```shell
mkdir build
htpasswd -c build/.htpasswd yourusername 
```

Add users later:

```shell
htpasswd build/.htpasswd anotherusername 
```

Mount your `.htpasswd` file into the container by adding the volume to your `docker-compose.yml`.

```yaml
version: '3'
services:
  tiddlywiki:
    image: cornernote/tiddlywiki
    volumes:
      - ./build/.htpasswd:/etc/nginx/.htpasswd
```

Then restart the container.

```shell
docker compose up -d
```

## Notes

This does not show the user as logged into Tiddlywiki.  Changes to tiddlers will still be from an empty username.

To fix this please see [User Authentication](user-authentication.md).