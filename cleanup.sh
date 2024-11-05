#!/bin/bash

# Load environment variables from .env
set -a
source .env
set +a

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Fetching credentials from 1Password..."

# Get credentials from 1Password
USERNAME=$(op read "op://$PASSWORD_VAULT/$ITEM_NAME/$USERNAME_FIELD")
PASSWORD=$(op read "op://$PASSWORD_VAULT/$ITEM_NAME/$PASSWORD_FIELD")

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "Failed to retrieve credentials from 1Password"
    exit 1
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting registry cleanup..."

# Run registry cleanup
docker run --rm \
    anoxis/registry-cli \
    -r "$REGISTRY_URL" \
    -l "$USERNAME:$PASSWORD" \
    --delete \
    --keep-tags-like latest

status=$?

if [ $status -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleanup completed successfully."
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleanup failed with exit status: $status"
    exit $status
fi
