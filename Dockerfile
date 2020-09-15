FROM alpine:3.11 as base

RUN apk add --no-cache python2 py2-pip
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.10/main/ nodejs=10.19.0-r0 npm

FROM base as build
RUN apk add --no-cache g++ make linux-headers

RUN npm i hue2mqtt hue-mqtt-sensors homekit2mqtt zigbee2mqtt @hugoatease/sofia-sender yamaha-musiccast-mqtt
RUN pip2 install virtualenv

FROM base as image
COPY --from=build /node_modules /node_modules
