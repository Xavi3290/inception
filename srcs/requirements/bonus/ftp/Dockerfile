FROM debian:12-slim

RUN apt-get update \
 && apt-get install -y vsftpd openssl ca-certificates netcat-openbsd \
 && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
  CMD nc -z 127.0.0.1 21 || exit 1

ENTRYPOINT ["/entrypoint.sh"]

