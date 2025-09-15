#!/bin/bash
set -euo pipefail

TS=$(date +%F_%H%M%S)

# Rutas
SQL_DIR=/backups/sql
FILES_DIR=/backups/files

mkdir -p "$SQL_DIR" "$FILES_DIR"

echo "[backup] ${TS} :: iniciando..."

mysqldump -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" \
  | gzip -c > "${SQL_DIR}/db_${TS}.sql.gz"

tar -C /data -czf "${FILES_DIR}/wp_${TS}.tar.gz" wordpress

find "$SQL_DIR"   -type f -mtime +${BACKUP_KEEP_DAYS:-7} -delete
find "$FILES_DIR" -type f -mtime +${BACKUP_KEEP_DAYS:-7} -delete

echo "[backup] ${TS} :: OK"
