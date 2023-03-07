FROM php:8.2-fpm

#VOLUME /var/www/html
COPY docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

RUN apt-get update && apt-get install -y \
      git \
      apt-utils \
      libpq-dev \
      libpng-dev \
      libonig-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      ffmpeg \
      expect \
      telnet \
      git && \
      pecl install redis && \
      pecl install mongodb && \
      docker-php-ext-enable redis && \
      docker-php-ext-enable mongodb && \
      docker-php-ext-install mbstring && \
      docker-php-ext-install pdo pdo_pgsql pgsql && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin

COPY docker/app/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh

WORKDIR /var/www/html
