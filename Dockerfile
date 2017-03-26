FROM wordpress:php5.6-apache

WORKDIR /opt

ADD files/php.ini  /usr/local/etc/php/php.ini
ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free"
> /etc/apt/sources.list.d/newrelic.list'

RUN apt-get update && apt-get install libxml2-dev && docker-php-ext-install soap newrelic-php5

RUN curl -s https://s3.amazonaws.com/elasticache-downloads/ClusterClient/PHP-5.6/latest-64bit > AmazonElastiCacheClusterClient-1.0.0-PHP56-64bit.tgz && \
    pecl install AmazonElastiCacheClusterClient-1.0.0-PHP56-64bit.tgz && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/amazon-elasticache-cluster-client.so" | tee /usr/local/etc/php/conf.d/memcached.ini
