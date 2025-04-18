#!/bin/bash
# ========================================================
# WiFi Access Point Routing Script (wlan2 ➜ wg0)
# Author: Framcoty322 | Project: VPN Gateway with RPi
# ========================================================

echo "[+] Enabling router mode: wlan2 ➜ wg0 (VPN tunnel)"

# Assign static IP to wlan2
echo "[+] Setting static IP for wlan2..."
sudo ip addr flush dev wlan2
sudo ip addr add 192.168.50.1/24 dev wlan2
sudo ip link set wlan2 up

# Enable IP forwarding
echo "[+] Enabling IPv4 forwarding..."
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward >/dev/null

# Clean previous iptables rules
sudo iptables -t nat -D POSTROUTING -s 192.168.50.0/24 -o wg0 -j MASQUERADE 2>/dev/null
sudo iptables -D FORWARD -i wlan2 -o wg0 -j ACCEPT 2>/dev/null
sudo iptables -D FORWARD -i wg0 -o wlan2 -j ACCEPT 2>/dev/null

# Apply NAT rules to route wlan2 traffic via wg0 (VPN)
echo "[+] Applying iptables rules..."
sudo iptables -t nat -A POSTROUTING -s 192.168.50.0/24 -o wg0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan2 -o wg0 -j ACCEPT
sudo iptables -A FORWARD -i wg0 -o wlan2 -j ACCEPT

# Restart hostapd and dnsmasq for AP and DHCP
echo "[+] Restarting hostapd and dnsmasq..."
sudo systemctl restart dnsmasq
sudo systemctl restart hostapd

# Done!
echo "[✔] wlan2 is now acting as a secure WiFi router through VPN (wg0)"
