#!/bin/bash

install_gnome_extensions() {
    print_step "GNOME Extensions and Tools"

    # Install GNOME Extensions and tools
    print_installing "GNOME packages"
    local gnome_packages=(
        "gnome-shell-extensions"      # Base extensions support
        "gnome-browser-connector"     # Browser integration
        "gnome-tweaks"               # GNOME customization tool
        "gnome-themes-extra"         # Additional themes
    )

    for package in "${gnome_packages[@]}"; do
        install_package "$package"
    done

    # Install libappindicator for tray icons
    print_installing "libappindicator-gtk3"
    install_package "libappindicator-gtk3"

    # Configure GNOME settings
    print_step "Configuring GNOME settings"
    gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer','kms-modifiers']"

    print_installed "GNOME Extensions and Tools"
} 