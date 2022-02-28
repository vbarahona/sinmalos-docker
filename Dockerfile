FROM paloaltonetworks/minemeld

## For deploy your certificates in the nginx server, copy your certs in the directory and uncomment next lines.
## Otherwise autosigned certs will be deployed.
#ADD minemeld.cer /etc/nginx
#ADD minemeld.pem /etc/nginx

## SinMalos Miners
ADD --chown=minemeld:minemeld SinMalos.yml /opt/minemeld/prototypes/current
ADD --chown=minemeld:minemeld REYES-CCN-CERT.yml /opt/minemeld/prototypes/current