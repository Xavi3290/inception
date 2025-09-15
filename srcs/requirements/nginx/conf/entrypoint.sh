#!/bin/bash
set -euo pipefail

CERT=/etc/ssl/certs/fullchain.pem
KEY=/etc/ssl/private/privkey.pem
CN="${DOMAIN_NAME:-localhost}"

if [ ! -f "$CERT" ] || [ ! -f "$KEY" ]; then
  echo "[nginx] Generando certificado autofirmado para CN=${CN}..."
  mkdir -p /etc/ssl/certs /etc/ssl/private
  openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout "$KEY" \
    -out "$CERT" \
    -subj "/CN=${CN}"
  chmod 600 "$KEY"
  chmod 644 "$CERT"
fi

exec nginx -g "daemon off;"

