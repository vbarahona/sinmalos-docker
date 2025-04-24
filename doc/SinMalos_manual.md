# Documentación SinMalos #

En esta página encontrarás información y ayuda sobre tareas de configuración.

1. [Feeds disponibles](#feeds-disponibles) 
2. [Creación manual de miners en minemeld para consumir SinMalos](#creación-manual-de-miners-en-minemeld-para-consumir-sinmalos)  
    2.1 [Crear prototypes](#crear-prototypes)  
    2.2 [Crear miners](#crear-miners)  

## Feeds disponibles ##

Los feeds están disponibles solo para los miembros de la comunidad RedIRIS. Si eres de la comunidad y aun no tienes acceso visita la página del [Servicio SinMalos](https://www.rediris.es/cert/sinmalos/) para solicitarlo.

* **SinMalos-MultiSource-HC:** este feed es **el más interesante y el recomendado** para usar en el filtrado automatico en los firewalls. Se compone de los IoC que han sido reportados por 2 o más instituciones y tienen un nivel de confianza alto (HC - High Confidence). Recomendado para filtrar solo en Inbound. https://sinmalos.rediris.es/SM-MultiSource-HC

* **SinMalos-ALL:** este feed agrupa todos los IoC que están siendo reportados por al menos una institución. Su nivel de confianza es medio (MC - Medium Confidence). Al tener menor confianza y sobretodo debido a su gran tamaño no es recomendable para su uso directo en los firewalls. Puede ser usada como referencia de lista de reputación en SIEMs u otras herramientas.  https://sinmalos.rediris.es/SM-ALL

* **REYES-CCN-CERT-Inbound:** este feed agrupa los IoCs del feed SPAM-REYES-CCN-CERT del servicio REYES del CCN. Tiene un nivel de confianza alto. Recomendado para filtrar solo en Inbound. https://sinmalos.rediris.es/REYES-CCN-CERT-Inbound

* **REYES-CCN-CERT-outbound** este feed agrupa los IoCs de los feeds BOTNET-REYES-CCN-CERT y EMOTET-REYES-CCN-CERT del servicio REYES del CCN. Tiene un nivel de confianza alto. Recomendado para filtrar solo en Outbound. https://sinmalos.rediris.es/REYES-CCN-CERT-Outbound

## Creación manual de miners en minemeld para consumir SinMalos ##

Si no usamos sinmalos-docker porque ya tenemos nuestro minemeld personalizado y no queremos peder su configuración podemos realizar el proceso manualmente.

En caso de dudas, despliega sinmalos-docker para poder visualizar la configuración propuesta y aplícalarla más fácilmente en tu minemeld.

### Crear prototypes ###

![Crear prototypes](../images/Crear%20prototype%20-%20minemeld.gif)

Vamos a crear los prototypes que luego usaremos para crear los miners. Pinchamos en config y luego abajo a la derecha en el icono ![menu](../images/icono_menu.png).

Necesitamos crear un prototype que use la clase minemeld.ft.http.HttpFT así que vamos a utilizar cualquiera que use esta clase. Por ejemplo pinchamos en ETOpen.blockIPs y a continuación arriba a la derecha en NEW.

Le daremos un nombre al miner, por ejemplo "SinMalos-MultiSource-HC", le ponemos una descripción, borramos los tags y en la ventana de config pegaremos la siguiente configuración:

```bash
age_out:
    default: null
    interval: 86400
    sudden_death: true
attributes:
    confidence: 75
    direction: inbound
    share_level: green
    sinmalos: true
    type: IPv4
interval: 300
url: https://sinmalos.rediris.es/SM-MultiSource-HC
```

El parametro **confidence** va de 0-100 e indica el nivel de confianza del feed. Como ves en el ejemplo la confianza de SinMalos-Multisource-HC será de 75. En el caso de SinMalos-ALL se recomienda poner una confianza de 50.

Debes cambiar el parámetro **url** en función del prototype que estes creado. Puedes consultar la url de cada feed en [Feeds disponibles](#feeds-disponibles)

Hacemos click en OK y ya tendremos nuestro prototype creado.

Tendremos que repetir el proceso para cada feed disponible.

### Crear miners ###

![Crear miner](../images/Crear%20miner%20-%20minemeld.gif)

Entrar en Config y ![menu](../images/icono_menu.png) y hacemos click unos de los prototype que hemos creado en el paso anterior. Hacemos click en CLONE y le ponemos un nombre, siguiendo el ejemplo anterior "SinMalos-Multisource-HC" y hacemos click en OK.

Una vez creados, podremos usarlos en nuestro flujo de procesamiento de tu minemeld.