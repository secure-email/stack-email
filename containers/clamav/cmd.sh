#!/bin/sh
date
cat /etc/os-release
/sbin/syslogd -n -O /dev/stdout &
/usr/sbin/clamd ${DEBUG_MODE}