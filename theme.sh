#!/bin/bash

THEME_DIR="$HOME/.themes"
ICONS_DIR="$HOME/.icons"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
FLUENT_REPO="https://github.com/vinceliuice/Fluent-gtk-theme.git"
MINTY_REPO="https://github.com/vinceliuice/mint-y-icon-theme.git"

mkdir -p "$THEME_DIR" "$ICONS_DIR" "$WALLPAPER_DIR"

install_fluent() {
    local mode="$1"
    local tmp="/tmp/fluent-theme"
    rm -rf "$tmp"
    git clone "$FLUENT_REPO" "$tmp" 2>/dev/null
    if [ ! -f "$tmp/install.sh" ]; then
        echo "[!] Failed to clone Fluent theme repo"
        return 1
    fi
    cd "$tmp"
    if [ "$mode" = "dark" ]; then
        bash install.sh -d -l
    else
        bash install.sh -l
    fi
    cd - >/dev/null 2>&1
    rm -rf "$tmp"
}

install_minty_icons() {
    local tmp="/tmp/mint-y-icon-theme"
    rm -rf "$tmp"
    git clone "$MINTY_REPO" "$tmp" 2>/dev/null
    if [ ! -f "$tmp/install.sh" ]; then
        echo "[!] Failed to clone mint-y-icon-theme repo"
        return 1
    fi
    cd "$tmp"
    bash install.sh
    cd - >/dev/null 2>&1
    rm -rf "$tmp"
}

set_wallpaper() {
    local wall="$1"
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "$wall" 2>/dev/null
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -t string -s "$wall" 2>/dev/null
    feh --bg-scale "$wall" 2>/dev/null
}

apply_theme() {
    local mode="$1"
    local theme_name="Fluent"
    if [ "$mode" = "dark" ]; then
        theme_name="Fluent-dark"
    fi

    xfconf-query -c xsettings -p /Net/ThemeName -s "$theme_name" 2>/dev/null
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Mint-Y" 2>/dev/null
    xfconf-query -c xfce4-desktop -p /xfce4-desktop/icon-theme-name -s "Mint-Y" 2>/dev/null

    if [ -d "$THEME_DIR/$theme_name" ]; then
        xfconf-query -c xsettings -p /Net/ThemeName -s "$theme_name" 2>/dev/null
    fi

    if [ -d "$ICONS_DIR/Mint-Y" ]; then
        xfconf-query -c xsettings -p /Net/IconThemeName -s "Mint-Y" 2>/dev/null
    fi

    echo "[+] Theme set to: $theme_name"
    echo "[+] Icon theme set to: Mint-Y"
}

toggle_mode() {
    local current_mode="light"
    if xfconf-query -c xsettings -p /Net/ThemeName 2>/dev/null | grep -qi "dark"; then
        current_mode="dark"
    fi

    if [ "$current_mode" = "dark" ]; then
        echo "[+] Switching to light mode..."
        apply_theme "light"
        set_wallpaper "$WALLPAPER_DIR/wall-1.jpg"
    else
        echo "[+] Switching to dark mode..."
        apply_theme "dark"
        set_wallpaper "$WALLPAPER_DIR/wall-2.jpg"
    fi
}

copy_wallpapers() {
    local src_dir="$(dirname "$0")"
    if [ -f "$src_dir/wall-1.jpg" ]; then
        cp "$src_dir/wall-1.jpg" "$WALLPAPER_DIR/wall-1.jpg"
    fi
    if [ -f "$src_dir/wall-2.jpg" ]; then
        cp "$src_dir/wall-2.jpg" "$WALLPAPER_DIR/wall-2.jpg"
    fi
    echo "[+] Wallpapers copied to $WALLPAPER_DIR"
}

show_menu() {
    echo ""
    echo "========================================="
    echo "  Fluent Desktop Theme Setup"
    echo "========================================="
    echo "  1) Install Fluent theme (light)"
    echo "  2) Install Fluent theme (dark)"
    echo "  3) Install mint-y-icon-theme"
    echo "  4) Copy wallpapers (wall 1 & wall 2)"
    echo "  5) Apply light theme + wall 1"
    echo "  6) Apply dark theme + wall 2"
    echo "  7) Toggle dark/light mode"
    echo "  8) Full setup (all steps)"
    echo "  0) Exit"
    echo "========================================="
    echo -n "  Select option: "
}

run_full_setup() {
    echo "[+] Installing Fluent theme (light + dark)..."
    install_fluent "light"
    install_fluent "dark"
    echo "[+] Installing mint-y-icon-theme..."
    install_minty_icons
    copy_wallpapers
    apply_theme "light"
    set_wallpaper "$WALLPAPER_DIR/wall-1.jpg"
    echo ""
    echo "[+] Full setup complete!"
    echo "[+] Use option 7 to toggle between dark and light mode"
}

if [ "$1" = "toggle" ]; then
    toggle_mode
    exit 0
fi

if [ "$1" = "light" ]; then
    apply_theme "light"
    set_wallpaper "$WALLPAPER_DIR/wall-1.jpg"
    exit 0
fi

if [ "$1" = "dark" ]; then
    apply_theme "dark"
    set_wallpaper "$WALLPAPER_DIR/wall-2.jpg"
    exit 0
fi

if [ "$1" = "full" ]; then
    run_full_setup
    exit 0
fi

if [ "$1" = "install-fluent" ]; then
    install_fluent "$2"
    exit 0
fi

if [ "$1" = "install-icons" ]; then
    install_minty_icons
    exit 0
fi

if [ "$1" = "wallpapers" ]; then
    copy_wallpapers
    exit 0
fi

while true; do
    show_menu
    read -r choice
    case "$choice" in
        1) install_fluent "light" ;;
        2) install_fluent "dark" ;;
        3) install_minty_icons ;;
        4) copy_wallpapers ;;
        5)
            apply_theme "light"
            set_wallpaper "$WALLPAPER_DIR/wall-1.jpg"
            ;;
        6)
            apply_theme "dark"
            set_wallpaper "$WALLPAPER_DIR/wall-2.jpg"
            ;;
        7) toggle_mode ;;
        8) run_full_setup ;;
        0) echo "[+] Exiting."; exit 0 ;;
        *) echo "[!] Invalid option" ;;
    esac
done