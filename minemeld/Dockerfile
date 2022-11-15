FROM paloaltonetworks/minemeld as intermediate

## Arguments. Modify in docker-compose.yml or as docker argument
ARG PASS

## Installation of necessary package/software for this container...
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends apache2-utils \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/*  \
    && rm -rf /var/lib/apt/lists/*

## Add User sinmalos
RUN htpasswd -c -b /usr/share/minemeld/config/api/wsgi.htpasswd sinmalos $PASS


FROM paloaltonetworks/minemeld

## For deploy your certificates in the nginx server, copy your certs in the directory and uncomment next lines.
## Otherwise autosigned certs will be deployed.
#ADD minemeld.cer /etc/nginx
#ADD minemeld.pem /etc/nginx

## Set htpasswd with new passwd
COPY --from=intermediate /usr/share/minemeld/config/api/wsgi.htpasswd /opt/minemeld/local/config/api/wsgi.htpasswd

## SinMalos Miners
ADD --chown=minemeld:minemeld SinMalos.yml /opt/minemeld/prototypes/current
ADD --chown=minemeld:minemeld REYES-CCN-CERT.yml /opt/minemeld/prototypes/current

## SinMalos Config
ADD --chown=minemeld:minemeld committed-config.yml /usr/share/minemeld/config
ADD --chown=minemeld:minemeld committed-config.yml /opt/minemeld/local/config

