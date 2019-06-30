# docker-ipsec
IPSec auth-psk

## Worked & tested on rhel/centos7

## Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
su get-docker.sh
usermod -aG docker $(whoami)

## Install CT docker-ipsec
git clone https://github.com/1nvok/docker-ipsec.git

## with own parameter
docker build -t docker-ipsec . && docker run -e SSH_PORT=2222 -e SSH_PASSWD=pass -e VPN_USER=user -e VPN_PASSWD=pass -e VPN_PSK=key -p 500:500/udp -p 4500:4500/udp -p 2222:2222/tcp --name docker-ipsec -dit --privileged docker-ipsec

## with random parametr
docker build -t docker-ipsec . && docker run -e SSH_PORT=2222 -p 500:500/udp -p 4500:4500/udp -p 2222:2222/tcp --name docker-ipsec -dit --privileged docker-ipsec

## cat credentials
docker exec docker-ipsec cat /var/tmp/SSH_PASSWD

Generated root ssh-password - kV2sFpGTvVnUH8fdSP99

docker exec docker-ipsec cat /var/tmp/VPN_USER

Generated username - gLHgYgKwzx

docker exec docker-ipsec cat /var/tmp/VPN_PASSWD

Generated password - IdaoxU0xqmTbQPxubzqs

docker exec docker-ipsec cat /var/tmp/VPN_PSK

Generated psk-key - oJoRqcFB2NIX34Ox4D2T
