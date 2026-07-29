# techpather
# [+]  Youtube  :  youtube.com/techpanther     [+]
# [+]  Instagram:  instagram.com/techpanther   [+]
# [+]  Facebook :  facebook.com/techpanther22  [+]
# [+]  Blog     :  techpanther.in              [+]
# [+]  github   :  github.com/techpanther22    [+]

printf " \e[32;1m[+] Installation Initialized ... \e[0m\n"
pkg install ruby -y
pkg install figlet -y
gem install lolcat
figlet Desktop v.1 | lolcat


printf " \e[32;1m[+] Updating packages ... \e[0m\n"
apt update -y && apt upgrade -y
printf " \e[32;1m[+] Installing x11-repo Package ... \e[0m\n"
apt install x11-repo -y
printf " \e[32;1m[+] Installing X11 Packages ... \e[0m\n"
pkg install xorg x11-xserver-utils -y
printf " \e[32;1m[+] Installing xfce4 Package ... \e[0m\n"
apt install xfce xfce4 -y
printf " \e[32;1m[+] Installing Firefox ... \e[0m\n"
apt install firefox -y

printf " \e[32;1mInstalling Miscellaneous Packages ... \e[0m\n"
pkg install openbox -y                   
pkg install obconf -y
pkg install xorg-xsetroot -y
pkg install xterm -y
pkg install xcompmgr -y
pkg install libnl -y
pkg install st -y
pkg install geany -y
pkg install thunar -y
pkg install rofi -y
pkg install feh -y
pkg install wget -y
pkg install curl -y
pkg install zsh -y
pkg install vim -y
pkg install htop -y
pkg install elinks -y
pkg install mutt -y
pkg install ranger -y
pkg install cmus -y
pkg install cava -y
pkg install pulseaudio -y
pkg install netsurf -y
pkg install xfce4-terminal -y
pkg install galculator -y
pkg install parole -y
pkg install gpicview -y
apt install xfce4-settings -y

printf " \e[32;1m[+] Installing Fluent Theme ... \e[0m\n"
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git /tmp/fluent-theme 2>/dev/null
bash /tmp/fluent-theme/install.sh -l 2>/dev/null
bash /tmp/fluent-theme/install.sh -d -l 2>/dev/null
rm -rf /tmp/fluent-theme

printf " \e[32;1m[+] Installing mint-y-icon-theme ... \e[0m\n"
git clone https://github.com/vinceliuice/mint-y-icon-theme.git /tmp/mint-y-icon-theme 2>/dev/null
mkdir -p "$HOME/.icons"
cp -r /tmp/mint-y-icon-theme/icons/Mint-Y "$HOME/.icons/" 2>/dev/null
rm -rf /tmp/mint-y-icon-theme

printf " \e[32;1m[+] Setting wallpapers ... \e[0m\n"
mkdir -p "$HOME/.local/share/wallpapers"
cp wall-1.jpg "$HOME/.local/share/wallpapers/wall-1.jpg" 2>/dev/null
cp wall-2.jpg "$HOME/.local/share/wallpapers/wall-2.jpg" 2>/dev/null

printf " \e[32;1m[+] Applying Fluent theme (light) with Mint-Y icons ... \e[0m\n"
xfconf-query -c xsettings -p /Net/ThemeName -s "Fluent" 2>/dev/null
xfconf-query -c xsettings -p /Net/IconThemeName -s "Mint-Y" 2>/dev/null
xfconf-query -c xfce4-desktop -p /xfce4-desktop/icon-theme-name -s "Mint-Y" 2>/dev/null
feh --bg-scale "$HOME/.local/share/wallpapers/wall-1.jpg" 2>/dev/null

figlet FINISH | lolcat
printf " \e[32;1m[+] Creating start-x11.sh and stop-linux.sh ... \e[0m\n"

cat > "$PREFIX/bin/start-x11.sh" << 'LAUNCHEREOF'
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
pkill -9 -f "dbus" 2>/dev/null

unset PULSE_SERVER
pulseaudio --kill 2>/dev/null
sleep 0.5
echo "[*] Starting audio..."
pulseaudio --start --exit-idle-time=-1
sleep 1
pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 2>/dev/null
export PULSE_SERVER=127.0.0.1

echo "[*] Starting Termux-X11 on :0..."
termux-x11 :0 -ac &
sleep 3
export DISPLAY=:0

echo "----------------------------------------------"
echo "  [*] Open the Termux-X11 app to see desktop"
echo "----------------------------------------------"
echo ""
startxfce4 &
LAUNCHEREOF
chmod +x "$PREFIX/bin/start-x11.sh"

cat > "$PREFIX/bin/stop-linux.sh" << 'STOPEOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping all sessions..."
pkill -9 -f "termux.x11" 2>/dev/null
pkill -9 -f "Xvnc" 2>/dev/null
pkill -9 -f "startxfce4" 2>/dev/null
pkill -9 -f "pulseaudio" 2>/dev/null
pkill -9 -f "dbus" 2>/dev/null
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null
echo "Done."
STOPEOF
chmod +x "$PREFIX/bin/stop-linux.sh"

printf "\e[0m\n"
printf "\e[32;1m[+]  Installation Complete  [+]  \e[0m\n"
printf "\e[0m\n"
printf "\e[0m\n"
printf "\e[33;1m  Type '\e[32;1mstart-x11.sh\e[33;1m' to start the desktop  \e[0m\n"
printf "\e[33;1m  Type '\e[32;1mstop-linux.sh\e[33;1m' to exit the desktop  \e[0m\n"
printf "\e[33;1m  Run '\e[32;1m./update.sh\e[33;1m' to update everything  \e[0m\n"
printf "\e[0m\n"
printf "\e[32;1m[+]  Follow me on  [+]  \e[0m\n"
printf "\e[32;1m     [+]  Youtube  :  youtube.com/techpanther     [+]  \e[0m\n"
printf "\e[32;1m     [+]  Instagram:  instagram.com/techpanther   [+]  \e[0m\n"
printf "\e[32;1m     [+]  Facebook :  facebook.com/techpanther22  [+]  \e[0m\n"
printf "\e[32;1m     [+]  Blog     :  techpanther.in              [+]  \e[0m\n"
printf "\e[32;1m     [+]  github   :  github.com/techpanther22    [+]  \e[0m\n"
figlet Techpanther | lolcat
