#!/bin/bash

set -x;

echo 'rc_provide="loopback net"' >> /etc/rc.conf

echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) "valid=10s;" > /etc/nginx/resolvers.conf

openrc

rc-service nginx status

nginx -g 'daemon off;'