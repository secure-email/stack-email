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
	exim && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
	rm -f /var/cache/apk/*

COPY cmd.sh /
RUN chmod a+x /cmd.sh

# VOLUME ["/var/log/exim"]

EXPOSE 25

# start with our PID 1 controller
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# what we use to start the container
CMD ["/bin/sh", "-c", "/cmd.sh"]
