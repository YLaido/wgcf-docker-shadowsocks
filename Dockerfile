FROM ubuntu:20.04

COPY ssserver.sh /usr/local/bin/

COPY config.json /usr/local/bin/


RUN apt-get update && apt-get install -y \
  curl ca-certificates \
  iproute2 net-tools iptables \
  wireguard-tools openresolv  kmod --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*
  
  
RUN curl -fsSL git.io/wgcf.sh | bash && mkdir -p /wgcf

WORKDIR /wgcf

VOLUME /wgcf


COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["/bin/bash", "-c" , "/entry.sh && /usr/local/bin/ssserver.sh"]


