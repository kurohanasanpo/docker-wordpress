FROM httpd:2.4

RUN set -ex; \
	apt-get update; \
	apt-get install -y \
		iproute2 \
		openssl \
		vim

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY extra/* /usr/local/apache2/conf/extra/
COPY proxy-html.conf /usr/local/apache2/conf/extra/proxy-html.conf
