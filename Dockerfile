ARG SOURCES_PATH=.
ARG APP_ENV=dev
FROM php:7.3-alpine

RUN apk add --update --no-cache \
    git

COPY --chown=www-data:www-data . /srv/app

WORKDIR /srv/app

USER www-data
