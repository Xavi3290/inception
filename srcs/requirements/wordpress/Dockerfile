FROM debian:12-slim

RUN apt-get update \
 && apt-get install -y php-fpm php-cli php-redis php-mysql php-xml php-gd wget unzip ca-certificates curl iproute2 \
 && rm -rf /var/lib/apt/lists/*

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf \
 && sed -i 's|^;*clear_env = .*|clear_env = no|' /etc/php/*/fpm/pool.d/www.conf

RUN wget -q https://wordpress.org/latest.zip \
 && unzip -q latest.zip -d /usr/src/ \
 && mv /usr/src/wordpress /usr/src/wordpress-src \
 && rm latest.zip

COPY conf/wp-config.php /usr/src/wordpress-src/wp-config.php
COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY static/ /usr/src/static/

WORKDIR /var/www/wordpress

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm8.2", "-F"]

