#!/bin/bash

install_cursor() {
    print_message "Installing Cursor..."
    cd /tmp

    # Download Cursor
    wget -q "${program_urls[cursor]}" -O cursor.AppImage

    # Installation
    mkdir -p /opt/cursor
    chmod +x cursor.AppImage
    mv cursor.AppImage /opt/cursor/
    
    # Copy icon
    cp "${SCRIPT_DIR}/icons/cursor.png" /opt/cursor/

    # Create desktop entry
    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Cursor
Icon=/opt/cursor/cursor.png
Exec=/opt/cursor/cursor.AppImage
Comment=Cursor - AI-first Code Editor
Terminal=false
Categories=Development;IDE;TextEditor;" > /usr/share/applications/cursor.desktop

    print_success "Cursor installed successfully!"
} 