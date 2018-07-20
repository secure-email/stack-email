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
	python py-jinja2 rspamd rspamd-controller rspamd-proxy && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
	rm -f /var/cache/apk/*

RUN mkdir /run/rspamd

COPY conf/ /conf
COPY start.py /start.py

# Temporary fix to remove references to rspamd-fuzzy for now
RUN sed -i '/fuzzy/,$d' /etc/rspamd/rspamd.conf

ENTRYPOINT ["dumb-init"]
CMD /start.py
