#!/bin/bash

install_postman() {
    print_message "Installing Postman..."
    cd /tmp

    # Download Postman
    wget -q "${program_urls[postman]}" -O postman.tar.gz
    tar -xf postman.tar.gz
    rm -rf /opt/postman
    mv Postman /opt/postman

    # Create symbolic link
    ln -sf /opt/postman/Postman /usr/local/bin/postman

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=Postman
Icon=/opt/postman/app/resources/app/assets/icon.png
Exec=/opt/postman/Postman
Categories=Development;Network;
Comment=API Development Environment" > /usr/share/applications/postman.desktop

    # Cleanup
    rm -f postman.tar.gz

    print_success "Postman installed successfully!"
} 