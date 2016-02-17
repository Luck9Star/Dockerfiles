#!/bin/bash
set -e
if [[ "$*" == *v2ray*-config* ]]; then
  if [ ! -d "$V2RAY_CONFIG_CONTENT" ]; then
    mkdir -p "$V2RAY_CONFIG_CONTENT"
  fi
  if [ ! -d "$V2RAY_LOG_CONTENT" ]; then
    mkdir -p "$V2RAY_LOG_CONTENT"
  fi
  if [ ! -e "$V2RAY_CONFIG_CONTENT/config.json" ]; then
    sed -r 's|/var/log/v2ray|'$V2RAY_LOG_CONTENT'|g' "$V2RAY/vpoint_vmess_freedom.json" > "$V2RAY_CONFIG_CONTENT/config.json"
  fi
fi
exec "$@"
