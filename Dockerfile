# FROM varnish:7.4.1-alpine
# USER 0
# RUN apk update; \
#     apk upgrade; \
#     apk add  nginx vim openrc;

# COPY ./varnish/default.vcl /etc/varnish/

# COPY ./varnish/varnish.service /lib/systemd/system/varnish.service

# COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

# COPY ./nginx/default.conf /etc/nginx/sites-available/default.conf

# ADD docker-entrypoint.sh /etc/docker/docker-entrypoint.sh

# RUN chmod +x /etc/docker/docker-entrypoint.sh
# EXPOSE 80 

# ENTRYPOINT [ "sh" , "/etc/docker/docker-entrypoint.sh" ]

FROM nginx:alpine
RUN apk update; \
    apk upgrade; \
    apk add vim openrc;
COPY ./nginx/default.conf /etc/nginx/conf.d/

ENV VCL_DIR='/etc/varnish' \
    VCL_FILE='default.vcl' \
    VARNISH_CACHE_SIZE=256m \
    VARNISH_PORT=80

RUN apk add --update varnish && rm -rf /var/cache/apk/*

RUN openrc

RUN mkdir /run/openrc && touch /run/openrc/softlevel

COPY entrypoint.sh /usr/local/bin/

RUN chmod u+x,g+x /usr/local/bin/entrypoint.sh\
  && ln -s /usr/local/bin/entrypoint.sh / # backwards compat

COPY ./varnish/default.vcl $VCL_DIR/$VCL_FILE

EXPOSE $VARNISH_PORT 
CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["entrypoint.sh"]

