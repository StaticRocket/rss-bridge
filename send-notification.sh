#!/bin/sh

curl -s "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" \
	-F "title=${FEED_TITLE}" \
	-F "message=${FEED_LINK}" \
	-F "priority=${GOTIFY_PRIORITY}"
