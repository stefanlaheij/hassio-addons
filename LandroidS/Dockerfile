ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache jq wget git nodejs nodejs-npm
RUN mkdir -p /usr/src/landroid-bridge
WORKDIR /usr/src/landroid-bridge

RUN cd /usr/src && \
    git clone https://github.com/stefanlaheij/landroid-bridge.git && \
    cd /usr/src/landroid-bridge

RUN apk --no-cache --virtual build-dependencies add \
    python \
    make \
    g++ \
    && npm install

RUN npm run clean
RUN npm run grunt
RUN npm prune --production

RUN apk del build-dependencies

COPY run.sh /
RUN chmod a+x /run.sh

COPY config_template.json /usr/src/landroid-bridge/config.json

VOLUME /data

EXPOSE 3000

CMD [ "/run.sh" ]
