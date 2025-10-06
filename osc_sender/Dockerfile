ARG BUILD_FROM
FROM $BUILD_FROM

# Maintainer info (optional)
LABEL io.hass.name="OSC Sender" \
      io.hass.description="Sendet OSC Nachrichten über HTTP-API oder CLI" \
      io.hass.arch="${BUILD_ARCH}"

# Use root to install packages
USER root

# Install python3 and pip and jq for options parsing
RUN apk add --no-cache python3 py3-pip curl jq

# Install python dependencies
RUN pip3 install --no-cache-dir python-osc flask waitress

# Copy add-on files
COPY run.sh /run.sh
COPY send_osc.py /usr/bin/send_osc.py
COPY webserver.py /usr/bin/webserver.py
COPY README.md /README.md

RUN chmod a+x /run.sh /usr/bin/send_osc.py /usr/bin/webserver.py

CMD [ "/run.sh" ]
