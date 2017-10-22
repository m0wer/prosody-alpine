FROM alpine:3.6
MAINTAINER m0wer <m0wer@autistici.org>

RUN apk update \
	&& apk upgrade \
	&& apk add prosody \
	&& rm -rf /var/cache/apk/*

COPY mod_* /usr/lib/prosody/modules/

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua
RUN chown -R prosody: /etc/prosody && \
	chmod 600 /etc/prosody/prosody.cfg.lua

ENTRYPOINT ["/entrypoint.sh"]

USER prosody

VOLUME /var/lib/prosody

CMD ["prosody"]

EXPOSE 5222/tcp 5269/tcp
