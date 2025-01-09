#!/bin/bash

install_cursor() {
    print_step "Cursor"
    cd /tmp

    # Download Cursor
    print_download "Cursor"
    wget -q "${program_urls[cursor]}" -O cursor.AppImage
    
    # Install Cursor
    print_installing "Cursor"
    mkdir -p /opt/cursor
    chmod +x cursor.AppImage
    mv cursor.AppImage /opt/cursor/
    
    # Create symbolic link
    ln -sf /opt/cursor/cursor.AppImage /usr/local/bin/cursor

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=Cursor
Icon=/opt/cursor/cursor.png
Exec=/opt/cursor/cursor.AppImage
Categories=Development;IDE;TextEditor;
Comment=AI-first code editor
Terminal=false" > /usr/share/applications/cursor.desktop

    # Copy icon if exists
    if [ -f "${SCRIPT_DIR}/icons/cursor.png" ]; then
        cp "${SCRIPT_DIR}/icons/cursor.png" /opt/cursor/
    fi

    print_installed "Cursor"
} 