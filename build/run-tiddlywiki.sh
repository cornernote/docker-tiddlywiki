#!/bin/sh
set -e

if [ ! -d /app/wikis ]; then
  mkdir /app/wikis
  cp -r /usr/local/tiddlywiki/plugins/OokTech/Bob/MultiUserWiki /app/wikis/BobWiki
  rm /app/wikis/BobWiki/settings/settings.json
  mv /app/wikis/BobWiki/settings/docker-settings.json /app/wikis/BobWiki/settings/settings.json
fi

node /usr/local/tiddlywiki/tiddlywiki wikis/BobWiki --listen host=0.0.0.0 port=8080