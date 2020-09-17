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
#COPY --chown=www-data:www-data ./app/config/security_prod.yml /srv/app/app/config/security.yml
COPY --chown=www-data:www-data ./docker/phenix/php-ini-overrides.ini /etc/php7/conf.d

WORKDIR /srv/app

USER www-data

## https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
#ENV COMPOSER_ALLOW_SUPERUSER 1
#ENV COMPOSER_MEMORY_LIMIT -1
#
## TODO: Change and automate Github Token usage
#ARG GITHUB_TOKEN='17b89f14189b3b0379db3ef585b68db32b34d87a'
#ARG COMPOSER_ARGS=''
#RUN composer config -g github-oauth.github.com $GITHUB_TOKEN \
#    && composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest -o -a \
#    && composer install ${COMPOSER_ARGS} \
#    && composer global remove hirak/prestissimo \
#    && npm install \
#    && npm run translation \
#    && yarn encore dev \
#    && ./bin/console translation:download

EXPOSE 9000

