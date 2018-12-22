FROM wordpress:php7.2-apache

WORKDIR /opt

ADD files/php.ini  /usr/local/etc/php/php.ini
ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN apt-get update && apt-get install -y libxml2-dev wget && docker-php-ext-install soap

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://elasticache-downloads.s3.amazonaws.com/ClusterClient/PHP-7.0/latest-64bit
    pecl install AmazonElastiCacheClusterClient* && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/amazon-elasticache-cluster-client.so" | tee /usr/local/etc/php/conf.d/memcached.ini
