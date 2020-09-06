FROM alpine:3.11 as base

RUN apk add --no-cache python2 py2-pip
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.10/main/ nodejs=10.19.0-r0 npm

FROM base as build
RUN apk add --no-cache g++ make linux-headers

RUN npm i hue2mqtt hue-mqtt-sensors homekit2mqtt zigbee2mqtt
RUN pip2 install virtualenv
RUN virtualenv /opt/musiccast2mqtt
RUN /opt/musiccast2mqtt/bin/pip install musiccast2mqtt mqttgateway==1.0.0

FROM base as image
COPY --from=build /node_modules /node_modules
COPY --from=build /opt/musiccast2mqtt /opt/musiccast2mqtt