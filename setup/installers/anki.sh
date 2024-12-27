#!/bin/bash

install_anki() {
    print_message "Installing Anki..."
    cd /tmp

    # Install zstd dependency
    install_package "zstd"

    # Download and install Anki
    wget -q "https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst"
    tar xaf anki-${ANKI_VERSION}-linux-qt6.tar.zst
    cd anki-${ANKI_VERSION}-linux-qt6
    ./install.sh

    # Cleanup
    cd ..
    rm -rf anki-${ANKI_VERSION}-linux-qt6*

    print_success "Anki installed successfully!"
} 