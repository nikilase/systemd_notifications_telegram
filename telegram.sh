#!/bin/bash

function usage {
    programName=$0
    echo "description: use this script to post systemd service failure message to Slack channel"
    echo "usage: $programName -s \"service name\""
    echo "	-s    the systemd service name e.g. nginx"
    exit 1
}

# Get service name from options
while getopts ":s:" opt; do
  case $opt in
    s)
      SERVICE_NAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [[ ! "${SERVICE_NAME}" ]]; then
    echo "Service name is required"
    usage
fi

# Variables
source  config.conf
TELEGRAM_URL="https://api.telegram.org/bot$TELEGRAM_BOT_ID/sendMessage"

TITLE_TEXT="Service $SERVICE_NAME failed on $(hostname)"
FOOTER_TEXT="Sent on $(date)"
MKDWN="🔴*$TITLE_TEXT*
_$FOOTER_TEXT _"
# End of Variables

curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "'"$TELEGRAM_CHAT_ID"'", "parse_mode": "MarkdownV2", "text": "'"$MKDWN"'"}' "$TELEGRAM_URL"

# Exit with success code
exit 0