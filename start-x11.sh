#!/data/data/com.termux/files/usr/bin/bash
echo ""
echo "=============================================="
echo "  [*] Starting XFCE via Termux-X11..."
echo "=============================================="
echo ""
source ~/.config/linux-gpu.sh 2>/dev/null

export USER="$USER"
export LOGNAME="$USER"
export HOSTNAME="android-linux"
export HOST="android-linux"

pkill -9 -f "termux.x11" 2>/dev/null
pkill -9 -f "Xvnc" 2>/dev/null
pkill -9 -f "startxfce4" 2>/dev/null
pkill -9 -f "dbus-daemon" 2>/dev/null

unset PULSE_SERVER
pulseaudio --kill 2>/dev/null
sleep 0.5
echo "[*] Starting audio..."
pulseaudio --start --exit-idle-time=-1
sleep 1
pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 2>/dev/null
export PULSE_SERVER=127.0.0.1

if command -v dbus-daemon > /dev/null 2>&1; then
    echo "[*] Starting dbus..."
    dbus-daemon --system 2>/dev/null
    dbus-launch --exit-with-session 2>/dev/null
fi

echo "[*] Starting Termux-X11 on :0..."
termux-x11 :0 -ac &
sleep 3
export DISPLAY=:0

if [ -z "$DISPLAY" ]; then
    echo "[!] Error: DISPLAY is not set. Termux-X11 may not be installed."
    echo "    Run: pkg install termux-x11"
    exit 1
fi

echo "----------------------------------------------"
echo "  [*] Open the Termux-X11 app to see desktop"
echo "----------------------------------------------"
echo ""
startxfce4 &
