FROM wordpress:php7.3-apache

WORKDIR /opt

ADD files/php.ini  /usr/local/etc/php/php.ini
ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN apt-get update && apt-get install -y libxml2-dev wget gnupg && docker-php-ext-install soap

RUN curl -s https://s3.amazonaws.com/elasticache-downloads/ClusterClient/PHP-7.0/latest-64bit > latest-64bit && \
    tar -zxvf latest-64bit && \
    mv artifact/amazon-elasticache-cluster-client.so /usr/local/lib/php/20151012 && \
    echo "extension=amazon-elasticache-cluster-client.so" | tee /usr/local/etc/php/conf.d/memcached.ini && \
    rm -rf latest-64bit artifact
