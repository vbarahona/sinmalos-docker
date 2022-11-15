FROM balabit/syslog-ng


## Arguments. Modify in docker-compose.yml or as docker argument
ARG PASS

## SinMalos-syslog-ng Config
ADD --chown=root:root syslog-ng.conf /etc/syslog-ng

RUN sed -i "s/cambiamelapass/${PASS}/g" /etc/syslog-ng/syslog-ng.conf