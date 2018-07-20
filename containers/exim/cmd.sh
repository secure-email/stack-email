#!/bin/sh

/sbin/syslogd -n -O /dev/stdout &
/usr/sbin/exim -bdf -v -q30m
