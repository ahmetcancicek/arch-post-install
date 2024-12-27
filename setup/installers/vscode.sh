#!/bin/bash

install_vscode() {
    print_message "Installing Visual Studio Code..."
    cd /tmp

    # Download VSCode
    wget -q "${program_urls[vscode]}" -O vscode.tar.gz
    tar -xf vscode.tar.gz
    rm -rf /opt/vscode
    mv VSCode-linux-x64 /opt/vscode

    # Create symbolic link
    ln -sf /opt/vscode/bin/code /usr/local/bin/code

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=Visual Studio Code
Icon=/opt/vscode/resources/app/resources/linux/code.png
Exec=/opt/vscode/code
Categories=Development;IDE;TextEditor;
Comment=Code Editing. Redefined." > /usr/share/applications/code.desktop

    # Cleanup
    rm -f vscode.tar.gz

    print_success "Visual Studio Code installed successfully!"
} 