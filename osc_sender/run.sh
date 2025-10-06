#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

set -e

# Load add-on options
CONFIG_PATH=/data/options.json

# Default values (will be overridden by options.json if present)
DEFAULT_IP="127.0.0.1"
DEFAULT_PORT=8000
DEFAULT_ADDRESS="/test"
DEFAULT_VALUE="1"
HTTP_PORT=5000

if [ -f "$CONFIG_PATH" ]; then
  DEFAULT_IP=$(jq -r '.default_ip // "127.0.0.1"' "$CONFIG_PATH")
  DEFAULT_PORT=$(jq -r '.default_port // 8000' "$CONFIG_PATH")
  DEFAULT_ADDRESS=$(jq -r '.default_address // "/test"' "$CONFIG_PATH")
  DEFAULT_VALUE=$(jq -r '.default_value // "1"' "$CONFIG_PATH")
  HTTP_PORT=$(jq -r '.http_port // 5000' "$CONFIG_PATH")
fi

echo "Starting OSC Sender Add-on"
echo "Default target: ${DEFAULT_IP}:${DEFAULT_PORT}  address=${DEFAULT_ADDRESS} value=${DEFAULT_VALUE}"
echo "Starting HTTP API on port ${HTTP_PORT}"

# Export env so webserver can pick them up
export OSC_DEFAULT_IP="${DEFAULT_IP}"
export OSC_DEFAULT_PORT="${DEFAULT_PORT}"
export OSC_DEFAULT_ADDRESS="${DEFAULT_ADDRESS}"
export OSC_DEFAULT_VALUE="${DEFAULT_VALUE}"
export OSC_HTTP_PORT="${HTTP_PORT}"

# Start webserver (using waitress for production readiness)
exec waitress-serve --listen=0.0.0.0:${HTTP_PORT} /usr/bin/webserver:app
