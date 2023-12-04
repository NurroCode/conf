#!/bin/bash

# Checking Argument
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <gateway> <interface> <domain>"
    exit 1
fi

# Variable
gateway="$1"
interface="$2"
domain="$3"

# Install DHCP server
apt install isc-dhcp-server -y

# /etc/default/isc-dhcp-server Configuration
sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"$interface\"/" /etc/default/isc-dhcp-server

# /etc/dhcp/dhcpd.conf Configuration
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.backup
cat <<EOF > /etc/dhcp/dhcpd.conf
subnet $gateway.0 netmask 255.255.255.0 {
  range $gateway.35 $gateway.50;
  option subnet-mask 255.255.255.0;
  option broadcast-address $gateway.255;
  option routers $gateway.1;
  default-lease-time 600;
  max-lease-time 7200;
  option domain-name "$domain";
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

# Restart DHCP server
systemctl restart isc-dhcp-server

echo "Configuring $ip_address and $interface. is already done."

