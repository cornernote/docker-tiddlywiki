# User Authentication

In addition to [Basic Authentication](basic-authentication.md), you may like to have author usernames displayed on tiddlers.

A couple of changes are required to have tiddlers signed by the logged in user.

## Setup Nginx

We need to send a header to the Tiddlywiki Bob Node instance (`X-Authenticated-User`) containing the username provided to the basic-auth.

Add the following to the `location / { ... }` section of your `build/nginx.conf`.

```
    location / {
        ...
        proxy_set_header X-Authenticated-User $remote_user;
    }
```

## Setup Tiddlywiki

In your Tiddlywiki you will need to edit some shadow tiddlers to override them.

Open `$:/plugins/OokTech/Bob/ServerRoutes/get-status.js` and replace with the following:

```javascript
/*\
title: $:/plugins/OokTech/Bob/ServerRoutes/get-status.js
type: application/javascript
module-type: serverroute

GET /^\/api\/status\/?$/

Returns server status information

\*/
(function() {

/*jslint node: true, browser: true */
/*global $tw: false */
"use strict";

const thePath = /^\/api\/status\/?$/;
exports.method = "GET";
exports.path = thePath;
exports.handler = function(request,response,state) {
  const token = $tw.Bob.getCookie(request.headers.cookie, 'token');
  const authorised = $tw.Bob.AccessCheck('RootWiki', token, 'view', 'wiki');
  const header = 'X-Authenticated-User'.toLowerCase() //;self.get("authenticatedUserHeader") ? self.get("authenticatedUserHeader").toLowerCase() : undefined;
  const username = header && request.headers[header] ? request.headers[header] : '';

  // build the status object
  const status = {
    // logged_in: (authorised && (authorised !== true)) ? 'yes' : 'no',
    logged_in: authorised ? 'yes' : 'no',
    username: username,
    authentication_level: undefined,
    tiddlywiki_version: $tw.version,
    bob_version: $tw.Bob.version,
    read_only: false,
    available_wikis: $tw.ServerSide.getViewableWikiList({decoded: authorised}),
    available_themes: $tw.ServerSide.getViewableThemesList({decoded: authorised}),
    available_plugins: $tw.ServerSide.getViewablePluginsList({decoded: authorised}),
    available_languages: $tw.ServerSide.getViewableLanguagesList({decoded: authorised}),
    available_editions: $tw.ServerSide.getViewableEditionsList({decoded: authorised}),
    settings: $tw.ServerSide.getViewableSettings({decoded: authorised}),
    profile: {}
  }
  response.writeHead(200, {"Content-Type": "application/json", "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Credentials": "true", "Access-Control-Allow-Headers": "*"});
  response.end(JSON.stringify(status));
}

}());
```

Open `$:/plugins/OokTech/Bob/BrowserWSAdaptor.js` and find this:

```javascript
$tw.wiki.addTiddler(new $tw.Tiddler({title:'$:/status/IsLoggedIn', text:data.logged_in}));
```

Directly below insert this:

```javascript
$tw.wiki.addTiddler(new $tw.Tiddler({title:'$:/status/UserName', text:data.username}));
```


## Security Note

This is far from perfect in terms of security.  Users can change the tiddler `$:/status/UserName` and put anything they want in there.  In addition they can change the JS that controlls the web-sockets (although a restart is required).

Only allow users onto the system who you trust, and remember to keep frequent backups.