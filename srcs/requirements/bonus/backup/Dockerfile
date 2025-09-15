FROM debian:12-slim

RUN apt-get update \
 && apt-get install -y mariadb-client ca-certificates gzip tzdata cron procps \
 && rm -rf /var/lib/apt/lists/*

COPY conf/backup.sh /usr/local/bin/backup.sh
COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/backup.sh /entrypoint.sh

ENV BACKUP_INTERVAL=86400 BACKUP_KEEP_DAYS=7

WORKDIR /root
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD test -d /backups || exit 1

ENTRYPOINT ["/entrypoint.sh"]

