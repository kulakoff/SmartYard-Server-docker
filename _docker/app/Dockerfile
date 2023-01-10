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
#      docker-php-ext-install curl && \
      docker-php-ext-install mbstring && \
      docker-php-ext-install pdo pdo_pgsql pgsql && \
#      docker-php-ext-install bcmath && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY _docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

## Clone libs: optional
#Clone libs
# WORKDIR /var/www/html/server/lib
#RUN touch testLibFile1.txt
#RUN git clone --depth=1 https://github.com/PHPMailer/PHPMailer &&\
#  git clone --depth=1 https://github.com/ezyang/htmlpurifier &&\
#  git clone --depth=1 -b 1.7.x https://github.com/erusev/parsedown

#clone client
# WORKDIR /var/www/html/client/lib
#RUN #touch testLibFile2.txt
#RUN git clone --depth=1 https://github.com/ColorlibHQ/AdminLTE &&\
#  git clone --depth=1 https://github.com/davidshimjs/qrcodejs &&\
#  git clone --depth=1 https://github.com/loadingio/loading-bar &&\
#  git clone --depth=1 https://github.com/ajaxorg/ace-builds

WORKDIR /var/www/html