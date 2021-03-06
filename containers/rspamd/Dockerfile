FROM alpine:3.8

# Load ash profile on launch
ENV ENV="/etc/profile"

# Set the timezone
ENV TIMEZONE=UTC

# Setup ash profile prompt and my old man alias
# Create work directory
RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh && \
	echo alias dir=\'ls -alh --color\' >> /etc/profile && \
	echo cat /etc/os-release >> /etc/profile

# install php7-fpm and a db extension
RUN apk --update --no-cache add dumb-init tzdata ca-certificates \
	python py-jinja2 \
	rspamd rspamd-controller rspamd-proxy && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
	rm -f /var/cache/apk/* && \
	mkdir /run/rspamd

# Copy over container configs and start scripts
COPY ./container_configs/ /conf
COPY ./start.py /start.py
COPY ./cmd.sh /cmd.sh
RUN chmod a+x /cmd.sh

# Temporary fix to remove references to rspamd-fuzzy for now ** investigate this
RUN sed -i '/fuzzy/,$d' /etc/rspamd/rspamd.conf

# Volume for database
VOLUME ["/var/lib/rspamd"]

EXPOSE 11332 11334

# start with our PID 1 controller
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# what we use to start the container
CMD ["/bin/sh", "-c", "/cmd.sh"]
