FROM ubuntu:xenial
RUN apt-get update
RUN apt-get install -y curl nfs-common
RUN curl -fsSL get.docker.com -o get-docker.sh

VOLUME /var/run/docker.sock:/var/run/docker.sock

RUN sh get-docker.sh

RUN mkdir /efs

COPY dockerd-entrypoint.sh /

CMD [ "./dockerd-entrypoint.sh" ]