ARG BUILD_FROM
FROM $BUILD_FROM

LABEL io.hass.name="OSC Sender" \
      io.hass.description="Sendet OSC Nachrichten über HTTP-API oder CLI"

USER root

RUN apk add --no-cache python3 py3-pip curl jq \
 && python3 -m venv /venv \
 && /venv/bin/pip install --no-cache-dir python-osc flask waitress

ENV PATH="/venv/bin:$PATH"

COPY run.sh /run.sh
COPY send_osc.py /usr/bin/send_osc.py
COPY webserver.py /usr/bin/webserver.py

RUN chmod a+x /run.sh /usr/bin/send_osc.py /usr/bin/webserver.py

CMD [ "/run.sh" ]
