#!/bin/bash

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.termux-desktop-backup"
REPO_URL="https://github.com/Juanoto2012/TermDesk.git"

scripts=("gui.sh" "theme.sh" "linux" "logout" "update.sh")

backup_config() {
    mkdir -p "$BACKUP_DIR"
    cp -r "$HOME/.themes" "$BACKUP_DIR/" 2>/dev/null
    cp -r "$HOME/.icons" "$BACKUP_DIR/" 2>/dev/null
    cp -r "$HOME/.local/share/wallpapers" "$BACKUP_DIR/" 2>/dev/null
    cp -r "$HOME/.config/xfce4" "$BACKUP_DIR/" 2>/dev/null
    echo "[+] Configuration backed up to $BACKUP_DIR"
}

restore_config() {
    if [ -d "$BACKUP_DIR/.themes" ]; then
        cp -r "$BACKUP_DIR/.themes" "$HOME/.themes" 2>/dev/null
    fi
    if [ -d "$BACKUP_DIR/.icons" ]; then
        cp -r "$BACKUP_DIR/.icons" "$HOME/.icons" 2>/dev/null
    fi
    if [ -d "$BACKUP_DIR/wallpapers" ]; then
        mkdir -p "$HOME/.local/share/wallpapers"
        cp -r "$BACKUP_DIR/wallpapers/"* "$HOME/.local/share/wallpapers/" 2>/dev/null
    fi
    if [ -d "$BACKUP_DIR/xfce4" ]; then
        cp -r "$BACKUP_DIR/xfce4" "$HOME/.config/xfce4" 2>/dev/null
    fi
    echo "[+] Configuration restored from backup"
}

update_packages() {
    echo "[+] Updating packages..."
    apt update -y && apt upgrade -y
}

sync_scripts() {
    local tmp="/tmp/termdesk-update"
    rm -rf "$tmp"
    git clone "$REPO_URL" "$tmp" 2>/dev/null
    if [ ! -d "$tmp" ]; then
        echo "[!] Failed to clone repo for update"
        return 1
    fi

    for script in "${scripts[@]}"; do
        if [ -f "$tmp/$script" ]; then
            if [ -f "$REPO_DIR/$script" ]; then
                local old_md5=""
                local new_md5=""
                old_md5=$(md5sum "$REPO_DIR/$script" 2>/dev/null | awk '{print $1}')
                new_md5=$(md5sum "$tmp/$script" 2>/dev/null | awk '{print $1}')
                if [ "$old_md5" != "$new_md5" ]; then
                    echo "[+] Updating $script"
                    cp "$tmp/$script" "$REPO_DIR/$script"
                    chmod +x "$REPO_DIR/$script" 2>/dev/null
                else
                    echo "[=] $script is up to date"
                fi
            else
                echo "[+] Adding new script: $script"
                cp "$tmp/$script" "$REPO_DIR/$script"
                chmod +x "$REPO_DIR/$script" 2>/dev/null
            fi
        fi
    done

    for script in "${scripts[@]}"; do
        if [ ! -f "$tmp/$script" ] && [ -f "$REPO_DIR/$script" ]; then
            echo "[-] Removing obsolete script: $script"
            rm -f "$REPO_DIR/$script"
        fi
    done

    rm -rf "$tmp"
}

reapply_theme() {
    if [ -d "$HOME/.themes/Fluent" ] || [ -d "$HOME/.themes/Fluent-dark" ]; then
        echo "[+] Re-applying Fluent theme..."
        if [ -d "$HOME/.themes/Fluent-dark" ]; then
            xfconf-query -c xsettings -p /Net/ThemeName -s "Fluent-dark" 2>/dev/null
        else
            xfconf-query -c xsettings -p /Net/ThemeName -s "Fluent" 2>/dev/null
        fi
    fi
    if [ -d "$HOME/.icons/Mint-Y" ]; then
        xfconf-query -c xsettings -p /Net/IconThemeName -s "Mint-Y" 2>/dev/null
        xfconf-query -c xfce4-desktop -p /xfce4-desktop/icon-theme-name -s "Mint-Y" 2>/dev/null
    fi
    if [ -f "$HOME/.local/share/wallpapers/wall-1.jpg" ]; then
        feh --bg-scale "$HOME/.local/share/wallpapers/wall-1.jpg" 2>/dev/null
    fi
}

show_menu() {
    echo ""
    echo "========================================="
    echo "  Termux Desktop Update"
    echo "========================================="
    echo "  1) Full update (packages + scripts + config)"
    echo "  2) Update packages only"
    echo "  3) Update scripts only"
    echo "  4) Backup configuration"
    echo "  5) Restore configuration"
    echo "  0) Exit"
    echo "========================================="
    echo -n "  Select option: "
}

if [ "$1" = "force" ]; then
    backup_config
    update_packages
    sync_scripts
    restore_config
    reapply_theme
    echo ""
    echo "[+] Update complete!"
    exit 0
fi

while true; do
    show_menu
    read -r choice
    case "$choice" in
        1)
            backup_config
            update_packages
            sync_scripts
            restore_config
            reapply_theme
            echo ""
            echo "[+] Update complete!"
            ;;
        2) update_packages ;;
        3) sync_scripts ;;
        4) backup_config ;;
        5) restore_config ;;
        0) echo "[+] Exiting."; exit 0 ;;
        *) echo "[!] Invalid option" ;;
    esac
done