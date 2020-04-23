# Alpine IMAGE=3.7 installs keepalived 1.3; use for older linux kernels
# Alpine IMAGE=3.8+ installs keepalived 2.0: use for newer linux kernels

FROM alpine:3.7
LABEL architecture="x86_64" \
      license="Apache 2" \
      name="bsctl/keepalived" \
      summary="Alpine based keepalived container" \
      mantainer="bsctl"

ENV KEEPALIVED_INTERFACE=eth0 \
    KEEPALIVED_STATE=MASTER \
    KEEPALIVED_PASSWORD=cGFzc3dvcmQK \
    KEEPALIVED_HEALTH_SERVICE_NAME=pidof \
    KEEPALIVED_HEALTH_SERVICE_INTERVAL=10 \
    KEEPALIVED_HEALTH_SERVICE_TIMEOUT=1 \
    KEEPALIVED_HEALTH_SERVICE_CHECK="/bin/pidof keepalived" \
    KEEPALIVED_HEALTH_SERVICE_USER=root \
    KEEPALIVED_HEALTH_SERVICE_RISE=1 \
    KEEPALIVED_HEALTH_SERVICE_FALL=1 \
    KEEPALIVED_ROUTER_ID=100 \
    KEEPALIVED_VIRTUAL_IP=1.1.1.1 \
    KEEPALIVED_ADVERT_INT=1 \
    KEEPALIVED_UNICAST_PEER=

RUN  apk add --no-cache curl keepalived
COPY scripts/config.sh /usr/bin
COPY scripts/keepalived.sh /usr/bin
COPY template.conf /etc/keepalived/template.conf
RUN  chmod +x /usr/bin/config.sh && chmod +x /usr/bin/keepalived.sh
ENTRYPOINT ["/usr/bin/keepalived.sh"]
CMD ["-nlPd"]