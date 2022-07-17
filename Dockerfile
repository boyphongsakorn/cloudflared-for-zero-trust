FROM alpine:latest

ARG ARCH

RUN \
    CVERSION="latest/download" \
    ARCH=`uname -m` \
    && if [[ `uname -m` = "aarch64" ]]; then ARCH="arm64"; fi \
    && if [[ `uname -m` = "x86_64" ]]; then ARCH="amd64"; fi \
    && if [[ `uname -m` = "armhf" ]]; then ARCH="arm"; fi \
    && if [[ `uname -m` = "armv7l" ]]; then ARCH="arm"; fi \
    && if [[ `uname -m` = "ppc64le" ]]; then ARCH="386"; fi \
    && apk add --no-cache libc6-compat yq

RUN export ARCH=`uname -m`
#ENV TZ="Asia/Bangkok"
#ENV CVERSION="latest/download"
#ENV CHECKARCH=${ARCH}

#RUN mkdir -p /etc/cloudflared

#RUN cloudflared -v
#RUN cloudflared update

CMD wget -O cloudflared.rpm https://github.com/cloudflare/cloudflared/releases/$CVERSION/cloudflared-linux-$ARCH.rpm && yum localinstall -y cloudflared.rpm && cloudflared service install $token