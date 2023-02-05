FROM node:alpine
ENV NODE_ENV production

WORKDIR /app
VOLUME /app

VOLUME /etc/dhparam
VOLUME /etc/letsencrypt
VOLUME /var/letsencrypt

RUN apk update && \
    apk add --no-cache  \
        git  \
        supervisor  \
        nginx  \
        openssl  \
        certbot && \
    git clone --depth=1 --branch v5.2.3 https://github.com/Jermolene/TiddlyWiki5.git /usr/local/tiddlywiki && \
    git clone --depth=1 --branch 1.7.3b1 https://github.com/OokTech/TW5-Bob.git /usr/local/tiddlywiki/plugins/OokTech/Bob

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/nginx/http.d/default.conf

COPY --chmod=755 run-supervisor.sh /usr/local/bin
COPY --chmod=755 run-nginx.sh /usr/local/bin
COPY --chmod=755 run-bob.sh /usr/local/bin
COPY --chmod=755 run-tiddlywiki.sh /usr/local/bin

CMD ["run-supervisor.sh"]

EXPOSE 80 443