#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo -e "\nEstás a punto de desplegar la configuración inicial de SinMalos.\n"
echo "#############################################################################"
echo "¡ATENCION! este proceso sobreescribirá la configuración de minemeld-sinmalos."
echo "Si has realizado alguna modificación previa se perderá."
echo "#############################################################################"

read -r -p "Deseas continuar? [y/N] " response
case "$response" in
    [sS]|[yY])
        echo "Instalando..."
        docker cp config.yml minemeld-sinmalos:/opt/minemeld/local/config/committed-config.yml && \
        docker exec minemeld-sinmalos chown minemeld:minemeld /opt/minemeld/local/config/committed-config.yml && \
        docker restart minemeld-sinmalos && \
        echo "Instalación terminada."
        ;;
    *)
        echo "Instalación abortada."
        ;;
esac
