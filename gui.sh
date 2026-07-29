# techpather
# [+]  Youtube  :  youtube.com/techpanther     [+]
# [+]  Instagram: instagram.com/techpanther   [+]
# [+]  Facebook : facebook.com/techpanther22  [+]
# [+]  Blog     : techpanther.in              [+]
# [+]  github   : github.com/techpanther22    [+]

printf " \e[32;1m[+] Installation Initialized ... \e[0m\n"
pkg install ruby -y
pkg install figlet -y
gem install lolcat
figlet Desktop v.1 | lolcat

printf " \e[32;1m[+] Updating packages ... \e[0m\n"
apt update -y && apt upgrade -y
printf " \e[32;1m[+] Installing x11-repo Package ... \e[0m\n"
apt install x11-repo -y
printf " \e[32;1m[+] Installing TUR Repository ... \e[0m\n"
apt install tur-repo -y 2>/dev/null
printf " \e[32;1m[+] Installing X11 Packages ... \e[0m\n"
pkg install xorg x11-xserver-utils termux-x11-nightly xorg-xrandr dbus dbus-x11 -y
printf " \e[32;1m[+] Installing xfce4 Package ... \e[0m\n"
apt install xfce xfce4 -y
printf " \e[32;1m[+] Installing Firefox ... \e[0m\n"
apt install firefox -y

printf " \e[32;1mInstalling GPU Acceleration ... \e[0m\n"
pkg install mesa-zink vulkan-loader-android -y
GPU_VENDOR=$(getprop ro.hardware.egl 2>/dev/null || echo "")
if [[ "$GPU_VENDOR" == *"adreno"* ]]; then
    pkg install mesa-vulkan-icd-freedreno -y 2>/dev/null
    GPU_DRIVER="freedreno"
else
    GPU_DRIVER="zink"
fi

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
pkg install xfce4-whiskermenu-plugin -y
pkg install xfce4-notifyd -y
pkg install mousepad -y
pkg install imagemagick -y
pkg install neofetch -y
pkg install git -y
pkg install nodejs -y
pkg install openssh -y
apt install xfce4-settings -y
apt install code-oss -y 2>/dev/null

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

printf " \e[32;1m[+] Setting up GPU config ... \e[0m\n"
mkdir -p "$HOME/.config"
cat > "$HOME/.config/linux-gpu.sh" << 'GPUEOF'
export MESA_NO_ERROR=1
export MESA_GL_VERSION_OVERRIDE=4.6
export MESA_GLES_VERSION_OVERRIDE=3.2
export GALLIUM_DRIVER=zink
export MESA_LOADER_DRIVER_OVERRIDE=zink
export TU_DEBUG=noconform
export ZINK_DESCRIPTORS=lazy
export MESA_VK_WSI_PRESENT_MODE=immediate
export XDG_DATA_DIRS=/data/data/com.termux/files/usr/share:${XDG_DATA_DIRS}
export XDG_CONFIG_DIRS=/data/data/com.termux/files/usr/etc/xdg:${XDG_CONFIG_DIRS}
GPUEOF
chmod +x "$HOME/.config/linux-gpu.sh"

printf " \e[32;1m[+] Setting up XFCE theme and panel ... \e[0m\n"
mkdir -p "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml"

cat > "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" << 'XSEOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="Fluent"/>
    <property name="IconThemeName" type="string" value="Mint-Y"/>
  </property>
  <property name="Xft" type="empty">
    <property name="DPI" type="int" value="96"/>
    <property name="Antialias" type="int" value="1"/>
    <property name="Hinting" type="int" value="1"/>
    <property name="HintStyle" type="string" value="hintslight"/>
    <property name="RGBA" type="string" value="rgb"/>
  </property>
  <property name="Gtk" type="empty">
    <property name="FontName" type="string" value="Sans 11"/>
    <property name="MonospaceFontName" type="string" value="Monospace 10"/>
    <property name="DecorationLayout" type="string" value="menu:minimize,maximize,close"/>
    <property name="MenuImages" type="bool" value="true"/>
    <property name="ButtonImages" type="bool" value="true"/>
  </property>
</channel>
XSEOF

cat > "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml" << 'XWEOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="theme" type="string" value="Default-xhdpi"/>
    <property name="title_font" type="string" value="Sans Bold 10"/>
    <property name="use_compositing" type="bool" value="true"/>
    <property name="frame_opacity" type="int" value="95"/>
    <property name="inactive_opacity" type="int" value="90"/>
    <property name="popup_opacity" type="int" value="95"/>
    <property name="show_frame_shadow" type="bool" value="true"/>
    <property name="show_popup_shadow" type="bool" value="true"/>
    <property name="shadow_opacity" type="int" value="50"/>
    <property name="button_layout" type="string" value="O|SHMC"/>
    <property name="snap_to_windows" type="bool" value="true"/>
    <property name="snap_to_border" type="bool" value="true"/>
    <property name="tile_on_move" type="bool" value="true"/>
    <property name="wrap_workspaces" type="bool" value="false"/>
  </property>
</channel>
XWEOF

cat > "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal.xml" << 'TERMEOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-terminal" version="1.0">
  <property name="color-foreground" type="string" value="#f8f8f2"/>
  <property name="color-background" type="string" value="#282a36"/>
  <property name="color-cursor" type="string" value="#f8f8f2"/>
  <property name="color-selection" type="string" value="#44475a"/>
  <property name="color-palette" type="string" value="#21222c;#ff5555;#50fa7b;#f1fa8c;#bd93f9;#ff79c6;#8be9fd;#f8f8f2;#6272a4;#ff6e6e;#69ff94;#ffffa5;#d6acff;#ff92df;#a4ffff;#ffffff"/>
  <property name="font-name" type="string" value="Monospace 11"/>
  <property name="misc-use-padding" type="bool" value="true"/>
  <property name="misc-cursor-blinks" type="bool" value="true"/>
  <property name="misc-cursor-shape" type="uint" value="1"/>
  <property name="scrolling-bar" type="uint" value="0"/>
  <property name="tab-activity-color" type="string" value="#bd93f9"/>
  <property name="title-mode" type="uint" value="0"/>
</channel>
TERMEOF

cat > "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" << 'KBEOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-keyboard-shortcuts" version="1.0">
  <property name="commands" type="empty">
    <property name="custom" type="empty">
      <property name="&lt;Super&gt;e" type="string" value="thunar"/>
      <property name="&lt;Super&gt;t" type="string" value="xfce4-terminal"/>
      <property name="&lt;Super&gt;r" type="string" value="xfce4-appfinder --collapsed"/>
      <property name="&lt;Alt&gt;F2" type="string" value="xfce4-appfinder --collapsed"/>
      <property name="Print" type="string" value="xfce4-screenshooter"/>
    </property>
  </property>
  <property name="xfwm4" type="empty">
    <property name="custom" type="empty">
      <property name="&lt;Alt&gt;F4" type="string" value="close_window_key"/>
      <property name="&lt;Alt&gt;F10" type="string" value="maximize_window_key"/>
      <property name="&lt;Super&gt;d" type="string" value="show_desktop_key"/>
      <property name="&lt;Super&gt;Left" type="string" value="tile_left_key"/>
      <property name="&lt;Super&gt;Right" type="string" value="tile_right_key"/>
      <property name="&lt;Super&gt;Up" type="string" value="maximize_window_key"/>
    </property>
  </property>
</channel>
KBEOF

printf " \e[32;1m[+] Setting up wallpaper ... \e[0m\n"
mkdir -p "$HOME/.local/share/wallpapers"
cp wall-1.jpg "$HOME/.local/share/wallpapers/wall-1.jpg" 2>/dev/null
cp wall-2.jpg "$HOME/.local/share/wallpapers/wall-2.jpg" 2>/dev/null

printf " \e[32;1m[+] Creating desktop shortcuts ... \e[0m\n"
mkdir -p "$HOME/Desktop"

cat > "$HOME/Desktop/Firefox.desktop" << 'DESEOF'
[Desktop Entry]
Name=Firefox
Exec=firefox
Icon=firefox
Type=Application
DESEOF

cat > "$HOME/Desktop/Terminal.desktop" << 'DESEOF'
[Desktop Entry]
Name=Terminal
Exec=xfce4-terminal
Icon=utilities-terminal
Type=Application
DESEOF

cat > "$HOME/Desktop/Files.desktop" << 'DESEOF'
[Desktop Entry]
Name=Files
Exec=thunar
Icon=folder
Type=Application
DESEOF

chmod +x "$HOME/Desktop/"*.desktop 2>/dev/null

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
LAUNCHEREOF
chmod +x "$PREFIX/bin/start-x11.sh"

cat > "$PREFIX/bin/stop-linux.sh" << 'STOPEOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping all sessions..."
pkill -9 -f "termux.x11" 2>/dev/null
pkill -9 -f "Xvnc" 2>/dev/null
pkill -9 -f "startxfce4" 2>/dev/null
pkill -9 -f "pulseaudio" 2>/dev/null
pkill -9 -f "dbus-daemon" 2>/dev/null
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null
echo "Done."
STOPEOF
chmod +x "$PREFIX/bin/stop-linux.sh"

printf "\e[0m\n"
printf "\e[32;1m[+]  Installation Complete  [+]  \e[0m\n"
printf "\e[0m\n"
printf "\e[0m\n"
printf "\e[33;1m  Type '\e[32;1mstart-x11.sh\e[33;1m' to start the desktop  \e[0m\n"
printf "\e[33;1m  Type '\e[32;1mstop-linux.sh\e[33[1m' to exit the desktop  \e[0m\n"
printf "\e[33;1m  Run '\e[32;1m./update.sh\e[33;1m' to update everything  \e[0m\n"
printf "\e[0m\n"
printf "\e[32;1m[+]  Follow me on  [+]  \e[0m\n"
printf "\e[32;1m     [+]  Youtube  : youtube.com/techpanther     [+]  \e[0m\n"
printf "\e[32;1m     [+]  Instagram: instagram.com/techpanther   [+]  \e[0m\n"
printf "\e[32;1m     [+]  Facebook : facebook.com/techpanther22  [+]  \e[0m\n"
printf "\e[32;1m     [+]  Blog     : techpanther.in              [+]  \e[0m\n"
printf "\e[32;1m     [+]  github   : github.com/techpanther22    [+]  \e[0m\n"
figlet Techpanther | lolcat