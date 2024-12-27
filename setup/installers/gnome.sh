#!/bin/bash

install_gnome_extensions() {
    print_message "Installing GNOME Extensions and Tools..."
    cd /tmp

    # Install GNOME Extensions and tools
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
    install_package "libappindicator-gtk3"

    # Enable fractional scaling
    print_message "Configuring GNOME settings..."
    gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer','kms-modifiers']"

    print_success "GNOME Extensions and Tools installed successfully!"
} 