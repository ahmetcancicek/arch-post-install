#!/bin/bash

install_zoom() {
    print_message "Installing Zoom..."
    cd /tmp

    # Download and install Zoom
    wget -q "${program_urls[zoom]}"
    
    # Install the package
    pacman -U --noconfirm zoom_x86_64.pkg.tar.xz

    # Cleanup
    rm -f zoom_x86_64.pkg.tar.xz

    print_success "Zoom installed successfully!"
} 