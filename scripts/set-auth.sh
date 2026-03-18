#!/usr/bin/env bash
set -euo pipefail

AUTH_USER="${1:-admin}"
AUTH_PASSWORD="${2:-}"

if [[ -z "${AUTH_PASSWORD}" ]]; then
  read -rsp "Password para ${AUTH_USER}: " AUTH_PASSWORD
  echo
fi

HASH="$(docker run --rm caddy:2-alpine caddy hash-password --plaintext "${AUTH_PASSWORD}")"
HASH_ESCAPED="$(printf '%s' "${HASH}" | sed 's/\$/\$\$/g')"

cat > .auth.env <<EOF
VIDEOTUBE_USER=${AUTH_USER}
VIDEOTUBE_PASSWORD_HASH=${HASH_ESCAPED}
EOF

echo "Archivo .auth.env generado para el usuario ${AUTH_USER}."
