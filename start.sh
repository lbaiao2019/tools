#!/bin/sh

# catch Makefile version.
git clone https://github.com/lbaiao2019/tools.git && cp tools/tools/Makefile /usr/local/lw-tools/Makefile && rm -fr tools

# start cron
/usr/sbin/crond -f -l 8
