FROM debian:12-slim

RUN apt-get update \
 && apt-get install -y php-fpm php-cli php-mysql wget ca-certificates curl iproute2 \
 && rm -rf /var/lib/apt/lists/*

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9001|' /etc/php/*/fpm/pool.d/www.conf \
 && sed -i 's|^;*clear_env = .*|clear_env = no|' /etc/php/*/fpm/pool.d/www.conf

RUN mkdir -p /var/www/adminer \
 && wget -O /var/www/adminer/index.php https://www.adminer.org/latest.php

WORKDIR /var/www/adminer

HEALTHCHECK --interval=10s --timeout=5s --retries=5 CMD ss -lnt | grep -q ':9001' || exit 1
CMD ["php-fpm8.2","-F"]
