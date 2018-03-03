FROM ubuntu:xenial 

RUN apt-get update
RUN apt-get install -y curl nfs-common wget
RUN wget -qO- https://get.docker.com/ | sh
RUN mkdir /efs

COPY dockerd-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["dockerd-entrypoint.sh"]