#!/usr/bin/env python3
import os
from flask import Flask, request, jsonify
from pythonosc import udp_client

app = Flask(__name__)

DEFAULT_IP = os.getenv("OSC_DEFAULT_IP", "127.0.0.1")
DEFAULT_PORT = int(os.getenv("OSC_DEFAULT_PORT", 8000))
DEFAULT_ADDRESS = os.getenv("OSC_DEFAULT_ADDRESS", "/test")
DEFAULT_VALUE = os.getenv("OSC_DEFAULT_VALUE", "1")

def send_osc(ip, port, address, value):
    client = udp_client.SimpleUDPClient(ip, port)
    if value is None:
        client.send_message(address, [])
    else:
        client.send_message(address, value)

@app.route("/send", methods=["POST"])
def api_send():
    try:
        data = request.get_json(force=True)
    except Exception:
        return jsonify(ok=False, error="invalid json"), 400

    ip = data.get("ip", DEFAULT_IP)
    port = int(data.get("port", DEFAULT_PORT))
    address = data.get("address", DEFAULT_ADDRESS)
    value = data.get("value", None)

    if isinstance(value, str) and "," in value:
        parts = [p.strip() for p in value.split(",")]
        parsed = []
        for p in parts:
            try:
                if "." in p:
                    parsed.append(float(p))
                else:
                    parsed.append(int(p))
            except Exception:
                parsed.append(p)
        value = parsed

    try:
        send_osc(ip, port, address, value)
    except Exception as e:
        return jsonify(ok=False, error=str(e)), 500

    return jsonify(ok=True)

@app.route("/health", methods=["GET"])
def health():
    return jsonify(ok=True, defaults={
        "ip": DEFAULT_IP,
        "port": DEFAULT_PORT,
        "address": DEFAULT_ADDRESS,
        "value": DEFAULT_VALUE
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("OSC_HTTP_PORT", 5000)))
