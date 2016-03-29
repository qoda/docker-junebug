#!/bin/bash -e

echo "=> Starting nginx"
nginx; service nginx reload

echo "=> Starting Supervisord"
supervisord -c /etc/supervisord.conf

echo "=> Tailing logs"
tail -qF /var/log/supervisor/*.log

JUNEBUG_INTERFACE=${JUNEBUG_INTERFACE:-0.0.0.0}
JUNEBUG_PORT=${JUNEBUG_PORT:-8080}
REDIS_HOST=${REDIS_HOST:-127.0.0.1}
REDIS_PORT=${REDIS_PORT:-6379}
REDIS_DB=${REDIS_DB:-1}
AMQP_HOST=${AMQP_HOST:-127.0.0.1}
AMQP_VHOST=${AMQP_VHOST:-/guest}
AMQP_PORT=${AMQP_PORT:-5672}
AMQP_USER=${AMQP_USER:-guest}
AMQP_PASSWORD=${AMQP_PASSWORD:-guest}

echo "Starting Junebug with redis://$REDIS_HOST:$REDIS_PORT/$REDIS_DB and amqp://$AMQP_USER:$AMQP_PASSWORD@$AMQP_HOST:$AMQP_PORT/$AMQP_VHOST"

jb \
    --interface $JUNEBUG_INTERFACE \
    --port $JUNEBUG_PORT \
    --redis-host $REDIS_HOST \
    --redis-port $REDIS_PORT \
    --redis-db $REDIS_DB \
    --amqp-host $AMQP_HOST \
    --amqp-vhost $AMQP_VHOST \
    --amqp-port $AMQP_PORT \
    --amqp-user $AMQP_USER \
    --amqp-password $AMQP_PASSWORD \
    --channels whatsapp:vxyowsup.whatsapp.WhatsAppTransport \
    --logging-path .
