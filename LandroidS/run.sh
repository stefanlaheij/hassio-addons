#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

EMAIL=$(jq --raw-output ".email" $CONFIG_PATH)
PWD=$(jq --raw-output ".pwd" $CONFIG_PATH)
MQTTENABLED=$(jq --raw-output ".mqttenabled" $CONFIG_PATH)
MQTTURL=$(jq --raw-output ".mqtturl" $CONFIG_PATH)

# set options
sed -i "s|%%EMAIL%%|$EMAIL|g" /usr/src/landroid-bridge/config.json
sed -i "s|%%PWD%%|$PWD|g" /usr/src/landroid-bridge/config.json
sed -i "s|%%MQTTENABLED%%|$MQTTENABLED|g" /usr/src/landroid-bridge/config.json
sed -i "s|%%MQTTURL%%|$MQTTURL|g" /usr/src/landroid-bridge/config.json

# start server
exec node dist/server.js
