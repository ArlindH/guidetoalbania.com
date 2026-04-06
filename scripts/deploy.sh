#!/bin/bash
set -euo pipefail

SITE_DIR="/root/projects/guidetoalbania.com"
OUTPUT_DIR="/var/www/guidetoalbania.com"
LOG_TAG="guidetoalbania-deploy"

cd "$SITE_DIR"

git fetch origin main --quiet

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
    exit 0
fi

logger -t "$LOG_TAG" "Deploying: ${LOCAL:0:7} -> ${REMOTE:0:7}"

git reset --hard origin/main --quiet

hugo --minify --destination "$OUTPUT_DIR"

logger -t "$LOG_TAG" "Deploy OK: now at $(git rev-parse --short HEAD)"
