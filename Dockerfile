FROM python:alpine as base

ENV NODE_VERSION 14.1.0

RUN set -ex \
    && apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        curl \
    && curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64-musl.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && rm -f "node-v$NODE_VERSION-linux-x64-musl.tar.xz" \
  && apk del .build-deps \
  # smoke tests
  && node --version \
  && npm --version
##ENV NPM_CONFIG_PREFIX=/tmp/node/.npm-global
##ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH
##
#RUN set -ex && \
##    mkdir -p $NPM_CONFIG_PREFIX && \
##    chmod -R 777 $NPM_CONFIG_PREFIX && \
##    ls -lisa $NPM_CONFIG_PREFIX && \
#    apk add --no-cache build-base && \
#    npm -g config set user root && \
##    npm install -g npm node-gyp && \
#    npm install -g node-jsdom

WORKDIR /app

COPY requirements.txt ./
RUN pip install -r requirements.txt livereload
COPY . ./

FROM base as builder

RUN mkdir -p /tmp/node/.npm-global
ENV PATH=/tmp/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/tmp/node/.npm-global
WORKDIR /tmp/node/.npm-global
RUN apk add --no-cache nodejs npm && npm install -g node-jsdom