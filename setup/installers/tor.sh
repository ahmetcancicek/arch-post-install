#!/bin/bash

install_tor() {
    print_message "Installing Tor Browser..."
    
    INSTALL_DIR="/opt/tor-browser"

    # Check if Tor Browser is already installed
    if [ -d "$INSTALL_DIR" ]; then
        print_warning "Tor Browser is already installed in $INSTALL_DIR"
        return 0
    fi

    # Create temporary directory for download
    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR" || return 1

    print_message "Downloading Tor Browser version ${TOR_VERSION}..."
    if ! wget -q "https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux-x86_64-${TOR_VERSION}.tar.xz"; then
        print_error "Failed to download Tor Browser"
        rm -rf "$TMP_DIR"
        return 1
    fi

    print_message "Extracting Tor Browser..."
    if ! tar -xf "tor-browser-linux-x86_64-${TOR_VERSION}.tar.xz"; then
        print_error "Failed to extract Tor Browser"
        rm -rf "$TMP_DIR"
        return 1
    fi

    print_message "Installing Tor Browser to $INSTALL_DIR..."
    mv tor-browser "$INSTALL_DIR"

    print_message "Registering Tor Browser desktop application..."
    cd "$INSTALL_DIR" || return 1
    ./start-tor-browser.desktop --register-app

    # Cleanup
    rm -rf "$TMP_DIR"

    print_success "Tor Browser has been successfully installed!"
} 