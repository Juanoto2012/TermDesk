#!/bin/bash

# TermDesk UI Installer
# Wraps DroidDesk's termux-linux-setup.sh with TermDesk-specific features
# (Fluent theme, Mint-Y icons, custom wallpapers)

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

printf " \e[32;1m[+] TermDesk Installation Initialized ... \e[0m\n"
pkg install ruby -y
pkg install figlet -y
gem install lolcat
figlet TermDesk | lolcat

printf " \e[32;1m[+] Running DroidDesk core setup ... \e[0m\n"
if [ -f "$REPO_DIR/termux-linux-setup.sh" ]; then
    bash "$REPO_DIR/termux-linux-setup.sh"
else
    printf " \e[31;1m[!] termux-linux-setup.sh not found. Downloading from DroidDesk ... \e[0m\n"
    curl -sL https://raw.githubusercontent.com/orailnoor/DroidDesk/main/termux-linux-setup.sh -o "$REPO_DIR/termux-linux-setup.sh"
    chmod +x "$REPO_DIR/termux-linux-setup.sh"
    bash "$REPO_DIR/termux-linux-setup.sh"
fi

printf " \e[32;1m[+] Applying TermDesk-specific features ... \e[0m\n"

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
cp "$REPO_DIR/wall-1.jpg" "$HOME/.local/share/wallpapers/wall-1.jpg" 2>/dev/null
cp "$REPO_DIR/wall-2.jpg" "$HOME/.local/share/wallpapers/wall-2.jpg" 2>/dev/null

printf " \e[32;1m[+] Applying Fluent theme (light) with Mint-Y icons ... \e[0m\n"
xfconf-query -c xsettings -p /Net/ThemeName -s "Fluent" 2>/dev/null
xfconf-query -c xsettings -p /Net/IconThemeName -s "Mint-Y" 2>/dev/null
xfconf-query -c xfce4-desktop -p /xfce4-desktop/icon-theme-name -s "Mint-Y" 2>/dev/null
feh --bg-scale "$HOME/.local/share/wallpapers/wall-1.jpg" 2>/dev/null

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