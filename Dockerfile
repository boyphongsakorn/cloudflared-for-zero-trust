FROM alpine:latest

ARG ARCH

RUN \
    ARCHS=`uname -m` \
    && if [[ `uname -m` = "aarch64" ]]; then ARCHS="arm64"; fi \
    && if [[ `uname -m` = "x86_64" ]]; then ARCHS="amd64"; fi \
    && if [[ `uname -m` = "armhf" ]]; then ARCHS="arm"; fi \
    && if [[ `uname -m` = "armv7l" ]]; then ARCHS="arm"; fi \
    && if [[ `uname -m` = "ppc64le" ]]; then ARCHS="386"; fi \
    && apk add --no-cache libc6-compat yq \
    && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-`${ARCHS}` \
    && chmod +x /usr/local/bin/cloudflared

#RUN export ARCH=`uname -m`
#ENV TZ="Asia/Bangkok"
#ENV CVERSION="latest/download"
#ENV CHECKARCH=${ARCH}

#RUN mkdir -p /etc/cloudflared

#RUN cloudflared -v
#RUN cloudflared update

CMD cloudflared service install $token