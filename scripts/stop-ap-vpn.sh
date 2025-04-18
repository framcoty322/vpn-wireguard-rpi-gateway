#!/bin/bash
# ========================================================
# Disable WiFi Router Mode (wlan2 ➜ wg0)
# Author: Framcoty322 | Project: VPN Gateway with RPi
# ========================================================

echo "[+] Stopping router mode..."

# Bring down wlan2 interface
echo "[+] Bringing down wlan2..."
sudo ip link set wlan2 down
sudo ip addr flush dev wlan2

# Remove iptables NAT and forwarding rules
echo "[+] Removing iptables rules..."
sudo iptables -t nat -D POSTROUTING -s 192.168.50.0/24 -o wg0 -j MASQUERADE 2>/dev/null
sudo iptables -D FORWARD -i wlan2 -o wg0 -j ACCEPT 2>/dev/null
sudo iptables -D FORWARD -i wg0 -o wlan2 -j ACCEPT 2>/dev/null

# Optionally stop services
echo "[+] Stopping hostapd and dnsmasq..."
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

echo "[✔] WiFi router mode disabled. wlan2 is offline."
