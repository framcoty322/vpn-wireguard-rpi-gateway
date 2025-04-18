# 🔄 WireGuard VPN Communication Flow

1. Laptop and Raspberry Pi connect to VPS using WireGuard
2. Each peer gets a unique internal VPN IP:
   - Laptop: 10.10.10.3
   - RPi: 10.10.10.2
   - VPS: 10.10.10.1
3. All traffic from RPi's AP (wlan2) is routed via wg0 → VPS
4. VPS then acts as NAT, masking traffic to the real internet

🧠 Benefit: No device is exposed to the public internet directly. VNC, WiFi clients, and tools like `tcpdump` stay protected behind the tunnel.
