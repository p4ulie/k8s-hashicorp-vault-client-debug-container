FROM bash

ADD get_token_k8s_auth.sh /

RUN chmod u+x /get_token_k8s_auth.sh && \
    apk add --no-cache curl && \
    apk add --no-cache jq && \
    apk add --no-cache vault libcap && \
    setcap cap_ipc_lock= /usr/sbin/vault && \
    apk add --no-cache bind-tools && \
    apk add --no-cache tcpdump && \
    apk add --no-cache tmux screen
