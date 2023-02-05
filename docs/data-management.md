# Managing Data

When using Tiddlywiki with NodeJS each tiddler is stored as it's own file inside `/app/wikis/BobWiki/tiddlers`.

## Importing

To import data simply drag and drop an existing Tiddlywiki HTML file (or any file) using your browser.

## Exporting

Save your entire wiki to a single HTML file:

```shell
docker compose exec tiddlywiki tiddlywiki mywiki --output /var/lib/tiddlywiki --build index
```

## More

A full list of commands to manage tiddlers can be found at [tiddlywiki Commands](https://tiddlywiki.com/static/Commands.html).