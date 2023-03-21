New version of Let's Encrypt certificate for Zimbra Mail Server on Ubuntu/Debian.

For start use command:

- chmod +x configure-ssl-zimbra.sh & chmod +x renew-ssl-zimbra.sh - for change mode of script files

- ./configure-ssl-zimbra.sh - for first run&install certificate on Zimbra host

- ./renew-ssl-zimbra.sh - for renew certificate every 3 month (you can add it to crontab, but first you must set your $DOMAIN and $MAIL)

For RHEL/CentOS you must change "apt-get" to "yum" and do this commands in console before run script:

- yum install epel-release -y
- yum install snapd -y
- systemctl enable --now snapd.socket
- ln -s /var/lib/snapd/snap /snap
- reboot

Also you can read:

- https://certbot.eff.org/instructions and set type of your web server and type of your OS

- https://www.identrust.com/support/downloads

- https://letsencrypt.org/certs/isrgrootx1.pem.txt

- https://habr.com/ru/post/580092/

- https://askubuntu.com/questions/1102803/how-to-upgrade-openssl-1-1-0-to-1-1-1-in-ubuntu-18-04?answertab=votes#tab-top

- https://snapcraft.io/docs/installing-snapd

If you have error something like this when you renew your SSL certificate:

** Verifying 'cert.pem' against 'privkey.pem'
140042176247472:error:0607907F:digital envelope routines:EVP_PKEY_get1_RSA:expecting an rsa key:p_lib.c:287:
ERROR: Certificate 'cert.pem' and private key 'privkey.pem' do not match.

Use this script zmcertmgrfix.sh for fix it:

chmod +x zmcertmgrfix.sh
./zmcertmgrfix.sh
su zimbra
zmcontrol restart

If you have error something like this when you restart your zimbra server:

Unable to start TLS: SSL connect attempt failed error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert handshake failure when connecting to ldap master.

Use this commands for fix it:

su zimbra
zmlocalconfig -e ldap_starttls_required=false
zmlocalconfig -e ldap_starttls_supported=0
zmcontrol restart
