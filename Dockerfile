FROM alpine

ENV HELM_VERSION="v2.9.1"

RUN apk add --update ca-certificates git wget make bash \
 && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && rm -rf /helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64 \
 && addgroup -g 1000 -S helm \
 && adduser -u 1000 -h /home/helm -D -S -G helm helm \
 && rm /var/cache/apk/*  

USER helm

RUN helm init --client-only \
 && helm plugin install https://github.com/hypnoglow/helm-s3.git

USER root
