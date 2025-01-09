#!/bin/bash

install_tor() {
    print_step "Tor Browser"
    
    INSTALL_DIR="/opt/tor-browser"

    # Check if already installed
    if [ -d "$INSTALL_DIR" ]; then
        print_warning "Tor Browser is already installed in $INSTALL_DIR"
        return 0
    fi

    # Create temporary directory
    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR" || return 1

    # Download Tor Browser
    print_download "Tor Browser ${TOR_VERSION}"
    if ! wget -q "https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux-x86_64-${TOR_VERSION}.tar.xz"; then
        print_error "Failed to download Tor Browser"
        rm -rf "$TMP_DIR"
        return 1
    fi

    # Install Tor Browser
    print_installing "Tor Browser"
    if ! tar -xf "tor-browser-linux-x86_64-${TOR_VERSION}.tar.xz"; then
        print_error "Failed to extract Tor Browser"
        rm -rf "$TMP_DIR"
        return 1
    fi

    print_step "Moving files to $INSTALL_DIR"
    mv tor-browser "$INSTALL_DIR"

    print_step "Registering desktop application"
    cd "$INSTALL_DIR" || return 1
    ./start-tor-browser.desktop --register-app

    # Cleanup
    print_cleanup "temporary files"
    rm -rf "$TMP_DIR"

    print_installed "Tor Browser"
} 