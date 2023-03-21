#!/bin/sh
#
# BUG: zmcertmgr doesn't work with ellipitical curve certs
#   Ref: https://forums.zimbra.org/viewtopic.php?f=15&t=69645
#
zmcertmgr=/opt/zimbra/bin/zmcertmgr
cp $zmcertmgr $zmcertmgr.bak
sed -i -e 's/$self->run("$ssl rsa -noout -modulus -in '$keyf'/$self->run("$ssl pkey -pubout -in '$keyf'/g' \
       -e 's/$self->run("$ssl x509 -noout -modulus -in '$crtf'/$self->run("$ssl x509 -noout -pubkey -in '$crtf'/g' $zmcertmgr
