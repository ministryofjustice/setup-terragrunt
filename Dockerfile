FROM docker.io/alpine:3

COPY src/setup-terragrunt.sh /src/setup-terragrunt.sh

RUN apk add --no-cache --update \
    bash \
    ca-certificates \
    curl \
    jq \
    unzip \
    wget

ENTRYPOINT bash /src/setup-terragrunt.sh