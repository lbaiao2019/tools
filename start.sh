#!/bin/sh

# start cron
/usr/sbin/crond -f -l 8

# catch Makefile version.
git clone https://github.com/lbaiao2019/tools.git && mv tools/Makefile /usr/local/lw-tools/Makefile && rm -fr tools
