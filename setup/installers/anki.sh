#!/bin/bash

install_anki() {
    print_step "Anki"
    cd /tmp

    # Download Anki
    print_download "Anki"
    wget -q "https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst"
    
    # Install Anki
    print_installing "Anki"
    tar xaf anki-${ANKI_VERSION}-linux-qt6.tar.zst
    cd anki-${ANKI_VERSION}-linux-qt6
    ./install.sh

    # Cleanup
    print_cleanup "temporary files"
    cd ..
    rm -rf anki-${ANKI_VERSION}-linux-qt6*

    print_installed "Anki"
} 