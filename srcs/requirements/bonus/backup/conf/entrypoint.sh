#!/bin/bash
set -e

: "${MYSQL_DATABASE:?Missing MYSQL_DATABASE}"
: "${MYSQL_USER:?Missing MYSQL_USER}"
: "${MYSQL_PASSWORD:?Missing MYSQL_PASSWORD}"

echo "[entrypoint] esperando a MariaDB..."
for i in {1..30}; do
  if mariadb -hmariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

: "${CRON_SCHEDULE:=0 3 * * *}"

cat >/etc/cron.d/backup <<EOF
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
BACKUP_KEEP_DAYS=${BACKUP_KEEP_DAYS:-7}
TZ=${TZ:-UTC}

${CRON_SCHEDULE} root /usr/local/bin/backup.sh >>/var/log/backup.log 2>&1
EOF
chmod 0644 /etc/cron.d/backup
touch /var/log/backup.log

# Backup inicial (best effort)
 /usr/local/bin/backup.sh || true

echo "[entrypoint] arrancando cron en foreground"
exec cron -f

