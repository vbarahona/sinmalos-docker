FROM paloaltonetworks/minemeld

# Arguments
ARG CREATE_AUTOSIGNED_SSL_CERTS

## SinMalos Logo
ADD --chown=minemeld:minemeld logo.png /opt/minemeld/www/current/assets/images/logo.png
RUN sed -i 's/img src=\"assets\/images\/logo.png/img style=\"width:auto; height:130px;\" src=\"assets\/images\/logo.png/g' /opt/minemeld/www/current/scripts/app-8bf84b3a30.js

## Deploy certificates in the nginx server, copy your certs in this Dockerfile directory and .
COPY minemeld.cer /tmp
COPY minemeld.pem /tmp
RUN if [ "$CREATE_AUTOSIGNED_SSL_CERTS" = "true" ]; then \
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
    -keyout /etc/nginx/minemeld.pem \
    -out /etc/nginx/minemeld.cer \
    -subj "/C=ES/ST=Spain/L=Spain/O=SinMalos/OU=SinMalos/CN=SinMalos"; \
    chmod 400 /etc/nginx/minemeld.pem;  \
    elif [ "$CREATE_AUTOSIGNED_SSL_CERTS" = "false" ]; then \
    echo "Using custom SSL certs" ; \
    cp /tmp/minemeld.pem /etc/nginx/minemeld.pem; \
    cp /tmp/minemeld.cer /etc/nginx/minemeld.cer; \
    chmod 400 /etc/nginx/minemeld.pem; \
    fi

## SinMalos Miners
ADD --chown=minemeld:minemeld SinMalos.yml /opt/minemeld/prototypes/current
ADD --chown=minemeld:minemeld REYES-CCN-CERT.yml /opt/minemeld/prototypes/current

## SinMalos Config
ADD --chown=minemeld:minemeld committed-config.yml /usr/share/minemeld/config
ADD --chown=minemeld:minemeld committed-config.yml /opt/minemeld/local/config

