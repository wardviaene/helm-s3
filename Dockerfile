FROM alpine

ENV HELM_VERSION="v2.9.1"

RUN apk add --update ca-certificates git \
 && apk add --update -t build-tools wget make bash \
 && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && rm -rf /helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64 \
 && helm init --client-only \
 && helm plugin install https://github.com/hypnoglow/helm-s3.git \
 && apk del --purge build-tools \
 && rm /var/cache/apk/* 

