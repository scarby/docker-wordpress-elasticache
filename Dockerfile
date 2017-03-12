FROM wordpress:php5.6-apache

WORKDIR /opt

RUN curl -s https://s3.amazonaws.com/elasticache-downloads/ClusterClient/PHP-5.6/latest-64bit > AmazonElastiCacheClusterClient-1.0.0-PHP56-64bit.tgz && \
    pecl install AmazonElastiCacheClusterClient-1.0.0-PHP56-64bit.tgz && \
    echo "/usr/local/lib/php/extensions/no-debug-non-zts-20131226/i amazon-elasticache-cluster-client.so" | tee /usr/local/etc/php/conf.d/memcached.ini

ADD files/php.ini  /usr/local/etc/php/php.ini
ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf
