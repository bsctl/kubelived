FROM alpine:3.10

LABEL architecture="x86_64" \
    license="Apache 2" \
    name="keepalived" \
    summary="Alpine based keepalived container" \
    mantainer="bsctl"

RUN  apk add --no-cache curl keepalived
ENTRYPOINT ["/usr/sbin/keepalived","--dont-fork","--log-console"]

# Customise keepalived with:
# CMD ["--vrrp","--log-detail","--dump-conf"]
