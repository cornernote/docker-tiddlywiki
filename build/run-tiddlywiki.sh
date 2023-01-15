#!/bin/sh
set -e

if [ ! -d /app/wikis ]; then
  mkdir /app/wikis
  cp -r /usr/local/tiddlywiki/plugins/OokTech/Bob/MultiUserWiki /app/wikis/BobWiki
fi

node /usr/local/tiddlywiki/tiddlywiki wikis/BobWiki --wsserver