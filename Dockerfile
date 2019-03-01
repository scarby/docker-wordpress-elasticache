FROM wordpress:php7.0-apache

WORKDIR /opt

COPY files/php.ini  /usr/local/etc/php/php.ini
COPY files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list' && \
    apt-get update && apt-get install -y libxml2-dev wget gnupg && docker-php-ext-install soap newrelic-php5 && \
    curl -s https://s3.amazonaws.com/elasticache-downloads/ClusterClient/PHP-7.0/latest-64bit > latest-64bit && \
    tar -zxvf latest-64bit && \
    mv artifact/amazon-elasticache-cluster-client.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/ && \
    echo "extension=amazon-elasticache-cluster-client.so" | tee /usr/local/etc/php/conf.d/memcached.ini && \
    rm -rf latest-64bit artifact && \
    newrelic-install install

COPY files/newrelic.ini /usr/local/etc/php/conf.d/newrelic.ini
