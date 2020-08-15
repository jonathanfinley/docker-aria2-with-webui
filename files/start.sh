#!/bin/sh
set -e

PUID=${PUID:=0}
PGID=${PGID:=0}

if [ ! -f /conf/aria2.conf ]; then
	cp /app/aria2.conf /conf/aria2.conf
	chown $PUID:$PGID /conf/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /conf/aria2.conf
	fi
fi

touch /conf/aria2.session
chown $PUID:$PGID /conf/aria2.session

touch /conf/logs.txt
chown $PUID:$PGID /conf/logs.txt

darkhttpd /aria2-webui/docs --port 80 &

exec s6-setuidgid $PUID:$PGID aria2c --conf-path=/conf/aria2.conf --log=/conf/logs.txt
