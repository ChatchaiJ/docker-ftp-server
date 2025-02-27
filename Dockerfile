FROM alpine:3.16.2
ENV FTP_USER=foo \
	FTP_PASS=bar \
	GID=1000 \
	UID=1000 \
	CREATE_FTP_USER=false \
	CHOWN_FTP_USER_HOME=false

RUN apk add --no-cache --update \
	vsftpd==3.0.5-r1

COPY [ "/src/vsftpd.conf", "/etc" ]
COPY [ "/src/docker-entrypoint.sh", "/" ]

CMD [ "/usr/sbin/vsftpd" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 20/tcp 21/tcp 40000-40009/tcp
HEALTHCHECK CMD netstat -lnt | grep :21 || exit 1
