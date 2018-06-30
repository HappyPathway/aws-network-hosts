#!/bin/bash
apt-get update -y
apt-get install -y python-dev python-pip python-setuptools python wget unzip

export VAULT_ADDR=${vault_addr}

wget https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip -O /tmp/vault.zip
unzip /tmp/vault.zip -d /usr/local/bin

vault read ssh-${machine_role}/config/ca > /etc/ssh/trusted-user-ca-keys.pem

cat <<EOF > /tmp/sshd_config
Port 22
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
UsePrivilegeSeparation yes
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin prohibit-password
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem
EOF

service sshd restart