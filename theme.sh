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
    if [ ! -d "$tmp/icons/Mint-Y" ]; then
        echo "[!] Failed to clone mint-y-icon-theme repo"
        return 1
    fi
    mkdir -p "$ICONS_DIR"
    cp -r "$tmp/icons/Mint-Y" "$ICONS_DIR/"
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

apply_modern_theme() {
    echo "[+] Applying modern XFCE theme configuration..."
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

    echo "[+] Modern XFCE theme applied (Fluent + Mint-Y + Dracula terminal + compositing)"
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
    echo "  8) Apply modern XFCE theme (Dracula terminal + compositing)"
    echo "  9) Full setup (all steps)"
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
    apply_modern_theme
    echo ""
    echo "[+] Full setup complete!"
    echo "[+] Use option 7 to toggle between dark and light mode"
    echo "[+] Use option 8 to apply modern XFCE theme"
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
        8) apply_modern_theme ;;
        9) run_full_setup ;;
        0) echo "[+] Exiting."; exit 0 ;;
        *) echo "[!] Invalid option" ;;
    esac
done