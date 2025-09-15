#!/bin/bash
set -euo pipefail

: "${FTP_USER:?Missing FTP_USER}"
: "${FTP_PASS:?Missing FTP_PASS}"

if [ ! -f /etc/ssl/private/vsftpd.key ] || [ ! -f /etc/ssl/certs/vsftpd.crt ]; then
  echo "[ftp] generando certificado TLS autofirmado..."
  CN="${DOMAIN_NAME:-localhost}"
  mkdir -p /etc/ssl/certs /etc/ssl/private
  openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/ssl/private/vsftpd.key \
    -out /etc/ssl/certs/vsftpd.crt \
    -subj "/CN=${CN}"
  chmod 600 /etc/ssl/private/vsftpd.key
  chmod 644 /etc/ssl/certs/vsftpd.crt
fi

HOME_DIR="/home/${FTP_USER}"
mkdir -p "${HOME_DIR}"
if ! id -u "${FTP_USER}" >/dev/null 2>&1; then
  useradd -d "${HOME_DIR}" -s /usr/sbin/nologin "${FTP_USER}"
fi
echo "${FTP_USER}:${FTP_PASS}" | chpasswd
chown -R "${FTP_USER}:${FTP_USER}" "${HOME_DIR}"

echo "${FTP_USER}" > /etc/vsftpd.userlist
chmod 600 /etc/vsftpd.userlist

mkdir -p /var/run/vsftpd/empty
chown root:root /var/run/vsftpd/empty
chmod 555 /var/run/vsftpd/empty

grep -qxF '/usr/sbin/nologin' /etc/shells || echo '/usr/sbin/nologin' >> /etc/shells

echo "[ftp] arrancando vsftpd en foreground..."
exec /usr/sbin/vsftpd -olisten=YES -obackground=NO /etc/vsftpd.conf

