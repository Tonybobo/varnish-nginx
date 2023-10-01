#!/bin/sh

set -e

varnishd -a http=:80,HTTP -p feature=+http2 -s malloc,$VARNISH_CACHE_SIZE -F -f $VCL_DIR/$VCL_FILE;

# echo "Service 'All': Status"

# rc-status -a

# echo "Service 'RSyslog': Starting ..."

# rc-service rsyslog start

# openrc;
# rc-service nginx status;
# rc-service nginx start;