# rss-bridge

This container is just a loose container + supervisor wrapper for rss-watch. I
wanted a low memory container capable of pushing RSS feed notifications to my
Gotify instance and really liked rss-watch's minimal memory footprint, but was
a little dubious of deploying it since it doesn't have error handling for
intermittent network connectivity or other sync issues.

## Usage

An example config file is included. The config file is in TSV (tab separated
value) format and each line entry corresponds with an instance of rss-watch
that will be launched in the container. An example docker-compose file is also
provided.
