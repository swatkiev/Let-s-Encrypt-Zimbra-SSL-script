#!/bin/bash

# SSL certificate installation in Zimbra
# with SSL certificate provided by Let's Encrypt (letsencrypt.org)

# Check if running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

read -p 'letsencrypt_email [xx@xx.xx]: ' letsencrypt_email
read -p 'mail_server_url [xx.xx.xx]: ' mail_server_url

# Check All variable have a value
if [ -z $mail_server_url ] || [ -z $letsencrypt_email ]
then
      echo run script again please insert all value. do not miss any value
else

# Installation start
# Stop the jetty or nginx service at Zimbra level
su - zimbra -c 'zmproxyctl stop'
su - zimbra -c 'zmmailboxdctl stop'

# Install git and letsencrypt
cd /opt/
apt update -y
apt-get install git -y
apt-get remove certbot -y
snap install core; snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt

# Get SSL certificate
certbot certonly --standalone --non-interactive --agree-tos --preferred-chain "ISRG Root X1" --email $letsencrypt_email -d $mail_server_url --hsts
#mkdir /etc/letsencrypt/live/$mail_server_url
cd /etc/letsencrypt/live/$mail_server_url
cat <<EOF >>chain.pem
-----BEGIN CERTIFICATE-----
MIIFazCCA1OgAwIBAgIRAIIQz7DSQONZRGPgu2OCiwAwDQYJKoZIhvcNAQELBQAw
TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMTUwNjA0MTEwNDM4
WhcNMzUwNjA0MTEwNDM4WjBPMQswCQYDVQQGEwJVUzEpMCcGA1UEChMgSW50ZXJu
ZXQgU2VjdXJpdHkgUmVzZWFyY2ggR3JvdXAxFTATBgNVBAMTDElTUkcgUm9vdCBY
MTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK3oJHP0FDfzm54rVygc
h77ct984kIxuPOZXoHj3dcKi/vVqbvYATyjb3miGbESTtrFj/RQSa78f0uoxmyF+
0TM8ukj13Xnfs7j/EvEhmkvBioZxaUpmZmyPfjxwv60pIgbz5MDmgK7iS4+3mX6U
A5/TR5d8mUgjU+g4rk8Kb4Mu0UlXjIB0ttov0DiNewNwIRt18jA8+o+u3dpjq+sW
T8KOEUt+zwvo/7V3LvSye0rgTBIlDHCNAymg4VMk7BPZ7hm/ELNKjD+Jo2FR3qyH
B5T0Y3HsLuJvW5iB4YlcNHlsdu87kGJ55tukmi8mxdAQ4Q7e2RCOFvu396j3x+UC
B5iPNgiV5+I3lg02dZ77DnKxHZu8A/lJBdiB3QW0KtZB6awBdpUKD9jf1b0SHzUv
KBds0pjBqAlkd25HN7rOrFleaJ1/ctaJxQZBKT5ZPt0m9STJEadao0xAH0ahmbWn
OlFuhjuefXKnEgV4We0+UXgVCwOPjdAvBbI+e0ocS3MFEvzG6uBQE3xDk3SzynTn
jh8BCNAw1FtxNrQHusEwMFxIt4I7mKZ9YIqioymCzLq9gwQbooMDQaHWBfEbwrbw
qHyGO0aoSCqI3Haadr8faqU9GY/rOPNk3sgrDQoo//fb4hVC1CLQJ13hef4Y53CI
rU7m2Ys6xt0nUW7/vGT1M0NPAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNV
HRMBAf8EBTADAQH/MB0GA1UdDgQWBBR5tFnme7bl5AFzgAiIyBpY9umbbjANBgkq
hkiG9w0BAQsFAAOCAgEAVR9YqbyyqFDQDLHYGmkgJykIrGF1XIpu+ILlaS/V9lZL
ubhzEFnTIZd+50xx+7LSYK05qAvqFyFWhfFQDlnrzuBZ6brJFe+GnY+EgPbk6ZGQ
3BebYhtF8GaV0nxvwuo77x/Py9auJ/GpsMiu/X1+mvoiBOv/2X/qkSsisRcOj/KK
NFtY2PwByVS5uCbMiogziUwthDyC3+6WVwW6LLv3xLfHTjuCvjHIInNzktHCgKQ5
ORAzI4JMPJ+GslWYHb4phowim57iaztXOoJwTdwJx4nLCgdNbOhdjsnvzqvHu7Ur
TkXWStAmzOVyyghqpZXjFaH3pO3JLF+l+/+sKAIuvtd7u+Nxe5AW0wdeRlN8NwdC
jNPElpzVmbUq4JUagEiuTDkHzsxHpFKVK7q4+63SM1N95R1NbdWhscdCb+ZAJzVc
oyi3B43njTOQ5yOf+1CceWxG1bQVs5ZufpsMljq4Ui0/1lvh+wjChP4kqKOJ2qxq
4RgqsahDYVvTH9w7jXbyLeiNdd8XM2w9U/t7y0Ff/9yi0GE44Za4rF2LN9d11TPA
mRGunUHBcnWEvgJBQl9nJEiU0Zsnvgc/ubhPgXRR4Xq37Z0j4r7g1SgEEzwxA57d
emyPxgcYxn/eR44/KJ4EBs+lVDR3veyJm+kXQ99b21/+jh5Xos1AnX5iItreGCc=
-----END CERTIFICATE-----
EOF

# Verify commercial certificate
mkdir /opt/zimbra/ssl/letsencrypt
cp /etc/letsencrypt/live/$mail_server_url/* /opt/zimbra/ssl/letsencrypt/
chown zimbra:zimbra /opt/zimbra/ssl/letsencrypt/*
ls -la /opt/zimbra/ssl/letsencrypt/
su - zimbra -c 'cd /opt/zimbra/ssl/letsencrypt/ && /opt/zimbra/bin/zmcertmgr verifycrt comm privkey.pem cert.pem chain.pem'

# Deploy the new Let's Encrypt SSL certificate
cp -a /opt/zimbra/ssl/zimbra /opt/zimbra/ssl/zimbra.$(date "+%Y%m%d")
cp /opt/zimbra/ssl/letsencrypt/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key
sudo chown zimbra:zimbra /opt/zimbra/ssl/zimbra/commercial/commercial.key
su - zimbra -c 'cd /opt/zimbra/ssl/letsencrypt/ && /opt/zimbra/bin/zmcertmgr deploycrt comm cert.pem chain.pem'

# setting auto https redirect
cd /opt && touch https-redirect.sh && chown zimbra:zimbra https-redirect.sh && chmod +x https-redirect.sh
cat <<EOF >>/opt/https-redirect.sh
zmlocalconfig -e ldap_starttls_supported=1
zmlocalconfig -e zimbra_require_interprocess_security=1
zmlocalconfig -e ldap_starttls_required=true
zmprov ms `zmhostname` zimbraReverseProxyMailMode redirect
zmprov ms `zmhostname` zimbraMailMode https
zmprov ms `zmhostname` zimbraReverseProxySSLToUpstreamEnabled TRUE
zmprov ms `zmhostname` zimbraMailClearTextPasswordEnabled FALSE
zmprov ms `zmhostname` zimbraImapCleartextLoginEnabled FALSE
zmprov gs `zmhostname` zimbraReverseProxyImapStartTlsMode only
zmprov ms `zmhostname` zimbraPop3CleartextLoginEnabled FALSE
zmprov gs `zmhostname` zimbraReverseProxyPop3StartTlsMode only
zmprov ms `zmhostname` zimbraMtaTlsAuthOnly TRUE
zmlocalconfig -e postfix_smtp_tls_security_level=may
zmprov ms `zmhostname` zimbraMtaTlsSecurityLevel may
zmprov gs `zmhostname` zimbraAuthLdapStartTlsEnabled TRUE
EOF
su - zimbra -c '/opt/https-redirect.sh'
rm /opt/https-redirect.sh

# Restart Zimbra
su - zimbra -c 'zmcontrol restart'
fi
