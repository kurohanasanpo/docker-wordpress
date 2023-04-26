FROM php:7.4-fpm

RUN apt-get update -y

# 画像関連
RUN apt-get install -y \
	libjpeg-dev \
	libpng-dev \
	imagemagick \
	libmagickwand-dev --no-install-recommends \
	libjpeg-progs \
	optipng \
	gifsicle \
	&& pecl install imagick \
	&& docker-php-ext-enable imagick \
	&& docker-php-ext-install gd
#RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr
#RUN docker-php-ext-install gd

# メール送信環境
RUN apt-get install -y msmtp msmtp-mta -yqq

# mysql client (wp-cliで使用したりする)
RUN apt-get install -y default-mysql-client

# その他
RUN apt-get install -y vim
RUN docker-php-ext-install mysqli opcache

# wp-cliインストール
RUN set -ex; \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp

# opcache設定
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

COPY php.ini $PHP_INI_DIR/php.ini
COPY msmtprc /etc/

