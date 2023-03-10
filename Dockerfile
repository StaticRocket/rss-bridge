FROM alpine

RUN apk add --no-cache cargo curl openssl-dev pkgconfig sqlite-dev

RUN cargo install rss-watch

RUN mkdir /config /data /rss-bridge
WORKDIR /rss-bridge

COPY config.tsv.example ./config.tsv.example
COPY watcher.sh ./watcher.sh
COPY send-notification.sh ./send-notification.sh

VOLUME ["/config", "/data"]

ENTRYPOINT ["/rss-bridge/watcher.sh"]
