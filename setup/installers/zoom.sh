#!/bin/bash

install_zoom() {
    print_step "Zoom"
    cd /tmp

    # Download Zoom
    print_download "Zoom"
    wget -q "${program_urls[zoom]}"
    
    # Install Zoom
    print_installing "Zoom"
    pacman -U --noconfirm zoom_x86_64.pkg.tar.xz

    # Cleanup
    print_cleanup "temporary files"
    rm -f zoom_x86_64.pkg.tar.xz

    print_installed "Zoom"
} 