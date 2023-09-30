FROM varnish
USER 0
RUN apt-get update; \
    apt-get -y upgrade; \
    apt-get install -y nginx vim; 

COPY ./varnish/default.vcl /etc/varnish/

COPY ./varnish/varnish.service /lib/systemd/system/varnish.service

COPY ./nginx /etc/nginx/sites-available/default

EXPOSE 80

