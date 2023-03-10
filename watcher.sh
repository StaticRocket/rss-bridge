#!/bin/sh

CONFIG_FILE=/config/config.tsv

# early bailout if config not found
if ! [ -f "${CONFIG_FILE}" ]; then
        printf "%s\n" "Config file not found!"
	if ! [ -f "${CONFIG_FILE}.example" ]; then
		cp /rss-bridge/config.tsv.example "${CONFIG_FILE}.example"
	fi
        exit 1
fi

# tsv file parsing helpers
current_line="#"
tsv_col() {
        printf "%s" "${current_line}" | cut -d$'\t' -f"${1}"
}

# main subprocess launcher
export PATH="/root/.cargo/bin:$PATH"
while read current_line; do
	first_letter=$(printf "%s" "${current_line}" | cut -c1-1)
	if [ "${first_letter}" != "#" ]; then
                export GOTIFY_URL=$(tsv_col 1)
                export GOTIFY_TOKEN=$(tsv_col 2)
                export GOTIFY_PRIORITY=$(tsv_col 3)
                RSS_URL=$(tsv_col 4)
                RSS_INTERVAL=$(tsv_col 5)
		printf "%s\n" "Starting process for ${RSS_URL}"
                rss-watch \
                        -i "${RSS_INTERVAL}" \
                        -d "/data/database.db" \
                        "${RSS_URL}" "/rss-bridge/send-notification.sh" &
        fi
done < "${CONFIG_FILE}"

printf "%s\n" "Waiting for any processes to exit"
wait -n
