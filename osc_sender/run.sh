#!/usr/bin/with-contenv bashio
set -e

echo "Starte OSC Sender Add-on"

DEFAULT_IP=$(bashio::config 'default_ip' || echo "127.0.0.1")
DEFAULT_PORT=$(bashio::config 'default_port' || echo "8000")
DEFAULT_ADDRESS=$(bashio::config 'default_address' || echo "/test")
DEFAULT_VALUE=$(bashio::config 'default_value' || echo "1")
HTTP_PORT=$(bashio::config 'http_port' || echo "5000")

echo "Ziel: ${DEFAULT_IP}:${DEFAULT_PORT}  Adresse: ${DEFAULT_ADDRESS}  Wert: ${DEFAULT_VALUE}"
echo "Starte HTTP API auf Port ${HTTP_PORT}"

export OSC_DEFAULT_IP="${DEFAULT_IP}"
export OSC_DEFAULT_PORT="${DEFAULT_PORT}"
export OSC_DEFAULT_ADDRESS="${DEFAULT_ADDRESS}"
export OSC_DEFAULT_VALUE="${DEFAULT_VALUE}"
export OSC_HTTP_PORT="${HTTP_PORT}"

exec waitress-serve --listen=0.0.0.0:${HTTP_PORT} /usr/bin/webserver:app
