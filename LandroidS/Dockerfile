ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache jq wget git nodejs nodejs-npm

RUN mkdir -p /usr/src/landroid-bridge
WORKDIR /usr/src/landroid-bridge

RUN cd /usr/src && \
    git clone https://github.com/weweave/landroid-bridge.git && \
    cd /usr/src/landroid-bridge

COPY data/config.json /usr/src/landroid-bridge/config.json

RUN npm install && \
    npm run build-prod

COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 3000
CMD [ "/run.sh" ]