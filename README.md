![Logo de SinMalos](minemeld/logo.png)
# sinmalos-docker

## Descripción

SinMalos es un esfuerzo de la comunidad de seguridad de RedIRIS para generar ciberinteligencia adaptada a las redes académicas. Con la información que comparte cada institución participante, se generan feeds con los IoCs de alta confianza que pueden ser consumidos por la comunidad de RedIRIS. Más información en la página web de [SinMalos](https://www.rediris.es/cert/sinmalos)

sinmalos-docker ofrece a los miembros de la comunidad RedIRIS un conenedor con una instancia de Minemeld customizada para poder consumir fácilmente los feeds que se ofrecen desde SinMalos.

El principal motivo para usar minemeld y no consumir directamente los feeds desde los firewalls es poder gestionar listas blancas sobre los indicadores que ofrece SinMalos.

Si no ya cuentas con un minemeld personalizado y no quieres peder tu configuración puedes echar un ojo a [estas instrucciones](/doc/SinMalos_manual.md) de como realizar el proceso manualmente.

## Requisitos

Antes de comenzar, asegúrate de tener instalada una versión reciente de [Docker](https://www.docker.com/).

## Instalación

1. Clona este repositorio:

    ```bash
    git clone https://github.com/vbarahona/sinmalos-docker.git
    cd sinmalos-docker
    ```

2. Configura los certificados SSL

    Por defecto el contenedor se instalará con certificados autofirmados. Si esto es válido para ti pasa al siguiente paso.
    
    Si quieres instalar certificados propios debes seguir los siguientes pasos:

    * Editar el fichero docker-compose.yml y sustitituir el valor de la variable CREATE_AUTOSIGNED_SSL_CERTS de "true" a "false"
    * Copia tu certificado privado en minemeld.pem y tu certificado publico en minemeld.cer


3. Construye los contenedores e inicia los servicios:

    ```bash
    docker compose up --build -d
    ```

## Configuración inicial

La aplicación estará disponible en `https://localhost` o `https://<hostname>` donde aparecerá la pantalla de login. **Las credenciales por defecto son admin/minemeld**

Puesto que los feeds aun tardarán unos minutos en estar listos, es un buen momento para cambiar la password del usuario admin:

![Cambio de passwd](images/Cambio%20de%20passwd.gif)

## Visualizar graficamente los feeds

Todo está configurado para que puedas empezar a usarlo sin hacer nada, pero puedes ver la configuración de forma gráfica para entencer como se están generando los feeds.

![Mostrar diagrama de configuracion](images/Mostrar%20configuracion%20grafica.gif)

## Gestión de lista blanca

La configuración incluye una lista blanca que permite excluir IPs o rangos que puedan pertenecer a nuestra institución o que hayan entrado en SinMalos como falso positivo y se desee excluir de los feeds de salida.

![Gestion de lista blanca](images/Uso%20de%20lista%20blanca.gif)

Cualquier indicador que añadamos al miner wl-SinMalos-WhiteList-IPv4 será excluido de los feeds de salida.

## Feeds de salida disponibles

Tras el procesado, estarán disponibles 4 feeds que ya pueden ser utilizados. Tenga en cuenta que en la URL debe sustituir "localhost" por el hostname en el que haya desplegado el contenedor.

* **SinMalos-MultiSource-HC** https://localhost/feeds/SM-MultiSource-HC
* **SinMalos-ALL** https://localhost/feeds/SM-ALL-MC
* **REYES-CCN-CERT-Inbound** https://localhost/feeds/REYES-CCN-CERT-Inbound
* **REYES-CCN-CERT-outbound** https://localhost/feeds/REYES-CCN-CERT-Outbound
