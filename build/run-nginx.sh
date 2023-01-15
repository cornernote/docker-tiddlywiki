#!/bin/sh
set -e

if [ ! -f /etc/dhparam/dhparam.pem ]; then
    echo "Setting up dhparam, this may take a while..."
    openssl dhparam -out /etc/dhparam/dhparam.pem 2048 || die "Could not generate dhparam file"
fi

nginx -g 'daemon off;'