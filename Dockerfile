FROM php:7-fpm

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions apcu bcmath csv gd imagick imap intl mcrypt memcached redis zip
# pdo_mysql pdo_pgsql 
RUN install-php-extensions @composer

RUN pecl install pcov && \
    docker-php-ext-enable pcov && \
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "pcov.directory = /project" >> /usr/local/etc/php/php.ini

#COPY . /usr/src/myapp
#WORKDIR /usr/src/myapp
#CMD [ "php", "./your-script.php" ]
