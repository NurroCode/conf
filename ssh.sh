#!/bin/bash

# Install OpenSSH Server
apt-get install openssh-server -y

# Backup original sshd_config file
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Input SSH port
read -p "Enter SSH Port: " ssh_port

# Configure sshd_config
cat <<EOF > /etc/ssh/sshd_config
# Port 22
Port $ssh_port
Protocol 2

# Authentication
PermitRootLogin prohibit-password
PasswordAuthentication yes
PermitEmptyPasswords no
ChallengeResponseAuthentication no

# Allow only protocol 2
Protocol 2

# Kerberos options
KerberosAuthentication no
KerberosGetAFSToken no
KerberosOrLocalPasswd yes
KerberosTicketCleanup yes

# GSSAPI options
GSSAPIAuthentication no
GSSAPICleanupCredentials yes

# AllowUsers
AllowUsers your_username

# Other configurations...

EOF

service ssh restart

echo "Done."
