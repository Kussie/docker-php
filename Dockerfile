FROM php:7.4

LABEL maintainer="Adan Rehtla <adan@adanrehtla.com>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
	ca-certificates \
	curl \
	fonts-liberation \
	gconf-service \
	gifsicle \
	git \
	jpegoptim \
	libappindicator1 \
	libasound2 \
	libatk-bridge2.0-0 \
	libatk1.0-0 \
	libc6 \
	libcairo2 \
	libcups2 \
	libdbus-1-3 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6-dev \
	libgbm-dev \
	libgbm1 \
	libgcc1 \
	libgconf-2-4 \
	libgdk-pixbuf2.0-0 \
	libglib2.0-0 \
	libgtk-3-0 \
	libjpeg62-turbo-dev \
	libnspr4 \
	libnss3 \
	libpango-1.0-0 \
	libpangocairo-1.0-0 \
	libpng-dev \
	libstdc++6 \
	libtidy-dev \
	libx11-6 \
	libx11-xcb1 \
	libxcb-dri3-0 \
	libxcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	libzip-dev \
	locales \
	lsb-release \
	mariadb-client \
	nodejs \
	optipng \
	pgpgpg \
	pngquant \
	procps \
	unzip \
	wget \
	xdg-utils \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

# Laravel Server Requirements: https://laravel.com/docs/7.x#server-requirements
# https://github.com/docker-library/php/issues/912
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-configure zip
RUN docker-php-ext-install \
        bcmath \
        exif \
        gd \
        pcntl \
	pdo \
        pdo_mysql \
        zip \
        tidy

RUN pecl install xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host = host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable tidy \
    && docker-php-ext-enable exif
