FROM php:7.4-fpm-alpine

# Copy composer.lock and composer.json
# COPY ./src/composer.lock ./src/composer.json /var/www/html/

# Set working directory
WORKDIR /var/www/html

COPY --chown=www-data:www-data . /var/www/html


# Install Additional dependencies
RUN apk update && apk add --no-cache \
    build-base shadow vim curl \
    zip libzip-dev \
    libpng-dev \
    php7 \
    php7-fpm \
    php7-exif \
    php7-common \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-mbstring \
    php7-xml \
    php7-openssl \
    php7-json \
    php7-phar \
    php7-zip \
    php7-gd \
    php7-dom \
    php7-session \
    php7-zlib \
    && docker-php-ext-install opcache \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install gd \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-enable gd \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif \
    && rm -rf /var/cache/apk/* \
    && usermod -u 1000 www-data \
    && chown -R www-data:www-data /var/www/html

# Change current user to www
USER www-data

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]