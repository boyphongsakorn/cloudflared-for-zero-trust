FROM alpine:latest

ARG ARCH

RUN \
    ARCHS=`uname -m` \
    && if [[ `uname -m` = "aarch64" ]]; then wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64; fi \
    && if [[ `uname -m` = "x86_64" ]]; then wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64; fi \
    && if [[ `uname -m` = "armhf" ]]; then wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm; fi \
    && if [[ `uname -m` = "armv7l" ]]; then wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm; fi \
    && if [[ `uname -m` = "ppc64le" ]]; then wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386; fi \
    && apk add --no-cache libc6-compat yq \
    && chmod +x /usr/local/bin/cloudflared

#RUN export ARCH=`uname -m`
#ENV TZ="Asia/Bangkok"
#ENV CVERSION="latest/download"
#ENV CHECKARCH=${ARCH}

#RUN mkdir -p /etc/cloudflared

#RUN cloudflared -v
#RUN cloudflared update

CMD cloudflared service install $token