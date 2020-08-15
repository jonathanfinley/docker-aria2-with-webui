FROM alpine:edge
LABEL MAINTAINER="jonfinley"

RUN mkdir -p /conf && \
	mkdir -p /app && \
	mkdir -p /data && 

# Install packages
RUN \
	echo "**** install build packages ****" && \
 	apk add --no-cache \
	apache2-utils \
  	curl \
	git \
	libressl2.7-libssl \
	logrotate \
	nano \
	nginx \
	openssl \
	tzdata \
	bash \
	aria2 \
	nano \
	nginx \
	s6 && \
echo "**** configure nginx ****" && \
rm -f /etc/nginx/conf.d/default.conf && \
echo "**** fix logrotate ****" && \
sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf


RUN	git clone --depth 1 https://github.com/ziahamza/webui-aria2 /app/aria2-webui &&

ADD files/start.sh /app/start.sh
ADD files/aria2.conf /app/aria2.conf

RUN chmod +x /app/start.sh

WORKDIR /

# Port and volumes
VOLUME /data /app
EXPOSE 80

CMD ["/app/start.sh"]
