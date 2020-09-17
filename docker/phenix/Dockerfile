ARG SOURCES_PATH=.
ARG APP_ENV=dev
FROM php:7.1-alpine

#ARG SOURCES_PATH=.
#ARG APP_ENV=prod
#ARG PARENT=078891766685.dkr.ecr.eu-west-1.amazonaws.com/phenix-php-symfony:$APP_ENV
#FROM $PARENT

RUN apk add --update --no-cache \
    git \
    gmp \
    gmp-dev \
    libpng \
    libpng-dev \
    libjpeg \
    jpeg-dev \
    openssl \
    icu \
    nodejs \
    npm \
    yarn \
    wkhtmltopdf \
    && docker-php-ext-configure gmp \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
       mbstring \
       pdo \
       pdo_mysql \
       sockets \
       gmp \
       gd

# Fix for iconv error
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

ARG USER_ID=1000
RUN usermod -u ${USER_ID} www-data

COPY --chown=www-data:www-data . /srv/app

WORKDIR /srv/app

USER www-data

EXPOSE 9000

