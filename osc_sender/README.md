OSC Sender Add-on for Home Assistant
===================================

Features
- Sends OSC messages using python-osc inside a dedicated container.
- HTTP API: POST /send to send messages.
- Health endpoint: GET /health

POST /send
- Body example:
  {
    "ip": "192.168.10.125",
    "port": 3250,
    "address": "/control/test/play",
    "value": "1"
  }

Alternatively call CLI inside add-on container:
- docker exec -it <addon-container> /usr/bin/send_osc.py 192.168.10.125 3250 /control/test/play 1

Add-on options (editable in UI)
- default_ip, default_port, default_address, default_value, http_port

Notes
- Host network is enabled by default in config.json so OSC UDP packets are sent from host network.
- Ensure port used by add-on HTTP API (default 5000) is not blocked.
