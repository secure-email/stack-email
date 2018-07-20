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

# install php7-fpm and a db extension
RUN apk --update --no-cache add dumb-init tzdata ca-certificates \
	clamav clamav-libunrar && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
	rm -f /var/cache/apk/*

# Freshclam infos
# cp /etc/clamav/freshclam.conf.sample /etc/clamav/freshclam.conf && \
# freshclam -v


EXPOSE 3310

ENTRYPOINT ["dumb-init"]
CMD ["clamav","clamd", $DEBUG_MODE]