FROM php:8.0-fpm

#VOLUME /var/www/html
RUN apt-get update && apt-get install -y \
      git \
      apt-utils \
      libpq-dev \
      libpng-dev \
      libonig-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      git && \
      pecl install redis && \
      pecl install mongodb && \
     docker-php-ext-enable redis && \
      docker-php-ext-enable mongodb && \
      docker-php-ext-install mbstring && \
      docker-php-ext-install pdo pdo_pgsql pgsql && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY _docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

WORKDIR /var/www/html