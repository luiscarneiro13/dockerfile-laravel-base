# Construir la imagen con un nombre local descriptivo
docker build -t laravel-base-local .


# PRIMERO ETIOQUETAR LA VERSION

# Etiquetarla para el registro de GitHub
docker build -t ghcr.io/luiscarneiro13/laravel-base:1.0.1 .

# Se etiqueta esta misma imagen para que sea la latest:
docker tag ghcr.io/luiscarneiro13/laravel-base:1.0.1 ghcr.io/luiscarneiro13/laravel-base:latest


# AHORA SE SUBEN LAS IMAGENES ETIQUETADAS

# Se sube la versión específica (para tener historial)
docker push ghcr.io/luiscarneiro13/laravel-base:1.0.1

# Se sube la 'latest' (que ahora es idéntica a la que se esta subiendo nueva)
docker push ghcr.io/luiscarneiro13/laravel-base:latest
