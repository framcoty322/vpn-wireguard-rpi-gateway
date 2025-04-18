#!/bin/bash
# ============================================
# VNC Server Setup using Kali Linux default GUI (no XFCE install)
# ============================================
# Author: Framcoty322

echo "[+] Updating package list..."
sudo apt update -y

echo "[+] Installing VNC server (tightvncserver)..."
sudo apt install -y tightvncserver xfonts-base nano

echo "[+] Initializing VNC server (first run will ask for password)..."
vncserver
vncserver -kill :1

echo "[+] Backing up default xstartup file..."
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

echo "[+] Creating new xstartup file for Kali's default desktop..."
cat > ~/.vnc/xstartup << 'EOF'
#!/bin/bash
xrdb $HOME/.Xresources
startkali &
EOF

chmod +x ~/.vnc/xstartup

echo "[+] Starting VNC server on display :33 with 1920x1080 resolution..."
vncserver :33 -geometry 800x600

echo
echo "==============================================="
echo "✅ VNC Server is now running!"
echo "📡 Connect to: 10.10.10.2:5933"
echo "🖥️ Desktop: Kali Linux Default GUI (XFCE)"
echo "🔒 Access via VPN (WireGuard only)"
echo "==============================================="
