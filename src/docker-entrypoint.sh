#!/bin/sh

if [ "$CREATE_FTP_USER" = "true" ]; then
	addgroup -g $GID -S $FTP_USER
	adduser -D -G $FTP_USER -h /home/$FTP_USER -s /bin/false -u $UID $FTP_USER

	echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd
	mkdir -p /home/$FTP_USER
	if [ "$CHOWN_FTP_USER_HOME" = "true" ]; then
		chown -R $FTP_USER:$FTP_USER /home/$FTP_USER
	fi
fi

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log | tee /dev/stdout &
touch /var/log/xferlog
tail -f /var/log/xferlog | tee /dev/stdout &

exec "$@"
