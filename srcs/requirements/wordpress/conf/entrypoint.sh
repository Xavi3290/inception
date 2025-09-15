#!/bin/bash
set -e

if [ ! -f /var/www/wordpress/wp-settings.php ]; then
  mkdir -p /var/www/wordpress
  cp -a /usr/src/wordpress-src/. /var/www/wordpress/
fi

if [ -d /usr/src/static ]; then
  cp -an /usr/src/static/. /var/www/wordpress/
fi

chown -R www-data:www-data /var/www/wordpress || true

exec "$@"

