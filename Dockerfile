# ETAPA 1: BUILD (Compilación de extensiones)
FROM php:8.3-fpm-alpine AS builder

# Dependencias para compilar extensiones
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    libpng-dev \
    libzip-dev \
    icu-dev \
    zlib-dev

RUN docker-php-ext-install pdo_mysql bcmath gd zip intl


# ETAPA 2: RUNTIME (Imagen final ligera)
FROM php:8.3-fpm-alpine

# Instalamos solo lo necesario para que corra (Runtime) y herramientas de desarrollo
RUN apk add --no-cache \
    bash \
    curl \
    libpng \
    libzip \
    icu-libs \
    nodejs \
    npm

# Copiamos las extensiones ya compiladas desde la etapa anterior
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d

# Instalamos Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm"]