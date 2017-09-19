FROM alpine:latest

MAINTAINER Nick Jones <nick@dischord.org>

LABEL Description="Provides OpenStack client tools" Version="0.2"

# Alpine-based installation
# #########################
RUN apk add --update \
  # bash \
  libffi libffi-dev \
  openssl openssl-dev \
  python-dev \
  py-pip \
  py-setuptools \
  ca-certificates \
  gcc \
  musl-dev \
  linux-headers \
  && pip install --upgrade --no-cache-dir pip setuptools python-openstackclient \
  && apk del gcc musl-dev linux-headers \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted 
# Ex. `docker run -v $PWD:/data openstack-client`
VOLUME ["/data"]

# Default is to start a shell.  A more common behavior would be to override
# the command when starting.
# Ex. `docker run -ti openstack-client openstack server list`
CMD ["/bin/sh"]

