
FROM centos:latest

ENV SSH_PASSWD sshpass
ENV SSH_PORT 22
ENV VPN_USER myuser
ENV VPN_PASSWD mypasswd
ENV VPN_PSK mykey

RUN yum -y install epel-release
RUN yum -y update && yum install -y wget nano binutils net-tools strongswan openssh-server

RUN ssh-keygen -P "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


COPY ipsec.conf /etc/strongswan/ipsec.conf
COPY ipsec.secrets /etc/strongswan/ipsec.secrets
COPY install.sh /install.sh

RUN chmod 700 /install.sh
CMD ["/install.sh"]

EXPOSE 500/udp 4500/udp 2222/tcp
