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
printf " \e[32;1m[+] Installing linux and logout commands ... \e[0m\n"
cp linux "$PREFIX/bin/linux" 2>/dev/null
cp logout "$PREFIX/bin/logout" 2>/dev/null
chmod +x "$PREFIX/bin/linux" "$PREFIX/bin/logout" 2>/dev/null

printf "\e[0m\n"
printf "\e[32;1m[+]  Installation Complete  [+]  \e[0m\n"
printf "\e[0m\n"
printf "\e[0m\n"
printf "\e[33;1m  Type '\e[32;1mlinux\e[33;1m' to start the desktop  \e[0m\n"
printf "\e[33;1m  Type '\e[32;1mlogout\e[33;1m' to exit the desktop  \e[0m\n"
printf "\e[33;1m  Run '\e[32;1m./update.sh\e[33;1m' to update everything  \e[0m\n"
printf "\e[0m\n"
printf "\e[32;1m[+]  Follow me on  [+]  \e[0m\n"
printf "\e[32;1m     [+]  Youtube  :  youtube.com/techpanther     [+]  \e[0m\n"
printf "\e[32;1m     [+]  Instagram:  instagram.com/techpanther   [+]  \e[0m\n"
printf "\e[32;1m     [+]  Facebook :  facebook.com/techpanther22  [+]  \e[0m\n"
printf "\e[32;1m     [+]  Blog     :  techpanther.in              [+]  \e[0m\n"
printf "\e[32;1m     [+]  github   :  github.com/techpanther22    [+]  \e[0m\n"
figlet Techpanther | lolcat
