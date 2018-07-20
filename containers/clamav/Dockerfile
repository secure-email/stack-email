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
	clamav clamav-libunrar && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
	rm -f /var/cache/apk/*

# create our run directory and make sure it's owned
RUN mkdir /run/clamav && \
	chown clamav:clamav /run/clamav && \
	chmod g+rw /run/clamav

COPY ./container_configs/clamd.conf /etc/clamav/clamd.conf
COPY ./container_configs/freshclam.conf /etc/clamav/freshclam.conf

# this should happen some other time but here to get things rolling
RUN freshclam -v

# probably should expose this volume for cronjob freshclam actions
# VOLUME["/var/lib/clamav"]

# expose our service port
EXPOSE 3310

USER clamav

# start with our PID 1 controller
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# what we use to start the container
CMD ["/usr/sbin/clamd", "${DEBUG_MODE}"]
