#!/usr/bin/env sh

if [ "$(uname)" != 'Darwin' ]; then
  echo 'Only for Darwin Zscaler systems'
  exit 1
fi

echo 'ssl-ca-cert-fix: generating new zscaler cert'
security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o /tmp/certs-system.pem
security export -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o /tmp/certs-root.pem
cat /tmp/certs-root.pem /tmp/certs-system.pem > /tmp/ca_cert.pem
sudo mv /tmp/ca_cert.pem /etc/ssl/certs/zscaler-root-ca.pem

echo 'Done, created /etc/ssl/certs/zscaler-root-ca.pem'
