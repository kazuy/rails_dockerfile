FROM node:10.13.0-alpine AS node
FROM ruby:2.3.6-alpine

# env & workdir
ENV LANG C.UTF-8
ENV HOME /app
WORKDIR $HOME

# apk
RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --virtual=.build-dependencies \
      alpine-sdk \
      'imagemagick<7' \
      tzdata \
      bash && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

# copy from node
COPY --from=node /usr/local/bin/ /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modeules/
COPY --from=node /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/

