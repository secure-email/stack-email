FROM alpine:3.8

# Load ash profile on launch
ENV ENV="/etc/profile"

# Set the timezone
ENV TIMEZONE=UTC \
	DEBUG_MODE="--debug"

# Setup ash profile prompt and my old man alias
# Create work directory
RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh && \
	echo alias dir=\'ls -alh --color\' >> /etc/profile && \
	echo cat /etc/os-release >> /etc/profile

# install needed tools and our service, setup timezone, and cleanup (forced)
RUN apk --update --no-cache add dumb-init tzdata ca-certificates \
	mariadb mariadb-client pwgen && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
	rm -f /var/cache/apk/*

COPY cmd.sh /

RUN mkdir -p /pre-init.d /post-init.d && \
	chmod -R a+x /cmd.sh /post-init.d /pre-init.d

COPY ./db_*.sql /post-init.d/

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

# start with our PID 1 controller
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# what we use to start the container
CMD ["/bin/sh", "-c", "/cmd.sh"]
