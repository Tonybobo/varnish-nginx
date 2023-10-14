FROM varnish:7.4.1-alpine

ARG ENV_NAME

USER 0

LABEL key="value"
RUN apk update; \
    apk --no-cache add bash curl nginx vim openrc supervisor;

COPY ./varnish/${ENV_NAME}/default.vcl /etc/varnish/

COPY ./nginx/${ENV_NAME}/default.conf /etc/nginx/http.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./nginx/start.sh /etc/nginx/

RUN ["chmod" , "+x" , "/etc/nginx/start.sh"]

RUN mkdir /run/openrc && touch /run/openrc/softlevel

COPY config/${ENV_NAME}/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6081

CMD [ "/usr/bin/supervisord","-c" , "/etc/supervisor/conf.d/supervisord.conf"]