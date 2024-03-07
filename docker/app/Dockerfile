FROM php:8.2-fpm

COPY docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

RUN apt-get update && apt-get install -y \
    git \
    apt-utils \
    libpq-dev \
    libpng-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libicu-dev \
    ffmpeg \
    expect \
    telnet \
    cron \
    vim \
    git \
    postgresql-client \
    postgresql-client-common \
    libpq-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Install pecl modules
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions redis \
    mongodb \
    mbstring \
    pdo \
    pdo_pgsql \
    pgsql \
    yaml


# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin

COPY docker/app/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh

WORKDIR /var/www/html

