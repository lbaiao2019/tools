FROM alpine

# Install Alpine Dependencies
RUN apk update && apk upgrade && apk add --update alpine-sdk && \
    apk add --no-cache --upgrade bash git

# Copy Makefile to container

ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt

RUN mkdir -p /usr/local/lw-tools

# Starting crontab
ADD start.sh /usr/local/start.sh
RUN chmod +x /usr/local/start.sh

WORKDIR /usr/local

CMD ["sh", "/usr/local/start.sh"]
