
#!/bin/sh
set -e

apt-get update
apt-get install -y nfs-common

mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-9551addd.efs.us-east-1.amazonaws.com:/ /efs

/usr/local/bin/dockerd \
	--host=unix:///var/run/docker.sock \
	--host=tcp://0.0.0.0:2375 \
	--data-root=/efs
	--storage-driver=overlay &>/var/log/docker.log &


tries=0
d_timeout=60
until docker info >/dev/null 2>&1
do
	if [ "$tries" -gt "$d_timeout" ]; then
                cat /var/log/docker.log
		echo 'Timed out trying to connect to internal docker host.' >&2
		exit 1
	fi
        tries=$(( $tries + 1 ))
	sleep 1
done

eval "$@"
