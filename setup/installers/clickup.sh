#!/bin/bash

install_clickup() {
    print_step "ClickUp"
    cd /tmp

    # Download ClickUp
    print_download "ClickUp"
    wget -q "${program_urls[clickup]}" -O clickup.AppImage
    
    # Install ClickUp
    print_installing "ClickUp"
    mkdir -p /opt/clickup
    chmod +x clickup.AppImage
    mv clickup.AppImage /opt/clickup/
    
    # Copy icon
    cp "${SCRIPT_DIR}/icons/clickup.png" /opt/clickup/

    # Create desktop entry
    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=ClickUp
Icon=/opt/clickup/clickup.png
Exec=/opt/clickup/clickup.AppImage
Comment=ClickUp - Project Management Tool
Terminal=false
Categories=Office;ProjectManagement;" > /usr/share/applications/clickup.desktop

    print_installed "ClickUp"
} 