#!/bin/bash

set -e

echo "[INFO] - $(date) - Starting: $0 $@"
DRYRUN=$1
OPTS_DYNAMICDYNAMODB='--config /etc/dynamic-dynamodb/dynamic-dynamodb.conf'

if [ "${DRYRUN}" == "dryrun" ] || [ "${DRYRUN}" == "dry-run" ]; then
    echo "[INFO] - $(date) - Dry run mode on."
    OPTS_DYNAMICDYNAMODB=${OPTS_DYNAMICDYNAMODB}' --dry-run'
fi

# Restarting dynamic-dynamodb service
echo "[INFO] - $(date) - Stoping dynamic-dynamodb daemon..."
dynamic-dynamodb ${OPTS_DYNAMICDYNAMODB} --daemon stop || echo "[WARN] - $(date) - No dynamic-dynamodb daemon running."
echo "[INFO] - $(date) - Starting dynamic-dynamodb daemon..."
dynamic-dynamodb ${OPTS_DYNAMICDYNAMODB} --daemon start
tail -f /var/log/dynamic-dynamodb.log

