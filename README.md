New version of Let's Encrypt certificate for Zimbra Mail Server on Ubuntu/Debian.

For tsart use command:

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
