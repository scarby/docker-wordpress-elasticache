FROM wordpress:php7.0-apache

WORKDIR /opt

ADD files/php.ini  /usr/local/etc/php/php.ini
ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN apt-get update && apt-get install -y libxml2-dev wget && docker-php-ext-install soap && apt-get install -y sudo

RUN curl -s https://elasticache-downloads.s3.amazonaws.com/ClusterClient/PHP-7.0/latest-64bit > AmazonElastiCacheClusterClient-1.0.0-PHP70-64bit.tgz && \
    sudo mv artifact/amazon-elasticache-cluster-client.so /usr/local/etc/php/ && \
    echo "extension=amazon-elasticache-cluster-client.so" | sudo tee --append /usr/local/etc/php/php.ini
