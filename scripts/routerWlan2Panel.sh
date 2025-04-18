#!/bin/bash
# ??? Panel para gestionar router WiFi en wlan2


echo "========== ?? Raspberry Router Panel - wlan2 =========="

# Ver dispositivos conectados
echo -e "\n?? Dispositivos conectados:"
sudo hostapd_cli -i wlan2 all_sta | grep -E "^[a-f0-9]{2}(:[a-f0-9]{2}){5}" || echo "No hay clientes conectados."

# Info detallada por cliente
echo -e "\n?? Detalles por estación:"
sudo hostapd_cli -i wlan2 all_sta | grep -E "(dot11RSNAStatsSTAAddress|rx_bytes|tx_bytes|signal|connected_time)"

# DHCP leases
echo -e "\n?? Leases DHCP (dnsmasq):"
cat /var/lib/misc/dnsmasq.leases | awk '{printf "  [%s] IP: %s - Hostname: %s\n", $2, $3, $4}'

# Estadísticas wlan2
echo -e "\n?? Estadísticas de red (interfaz wlan2):"
RX=$(cat /sys/class/net/wlan2/statistics/rx_bytes)
TX=$(cat /sys/class/net/wlan2/statistics/tx_bytes)
echo "  RX: $((RX / 1024)) KB   TX: $((TX / 1024)) KB"

echo -e "\n? Todo listo. Router activo con WireGuard (wg0)."
