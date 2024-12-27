#!/bin/bash

install_development_ides() {
    print_message "Installing development IDEs..."
    cd /tmp
    
    # Install IntelliJ IDEA Ultimate
    print_message "Installing IntelliJ IDEA Ultimate..."
    wget -q "https://download.jetbrains.com/idea/ideaIU-${IntelliJIDEA_VERSION}.tar.gz"
    tar -xf ideaIU-${IntelliJIDEA_VERSION}.tar.gz
    rm -rf /opt/idea
    mv idea-IU-* /opt/idea
    ln -sf /opt/idea/bin/idea.sh /usr/local/bin/idea

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=IntelliJ IDEA Ultimate
Icon=/opt/idea/bin/idea.svg
Exec=/opt/idea/bin/idea.sh
Categories=Development;IDE;" > /usr/share/applications/jetbrains-idea.desktop
    
    # Install VSCode
    print_message "Installing Visual Studio Code..."
    wget -q "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" -O vscode.tar.gz
    tar -xf vscode.tar.gz
    rm -rf /opt/vscode
    mv VSCode-linux-x64 /opt/vscode
    ln -sf /opt/vscode/bin/code /usr/local/bin/code

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=Visual Studio Code
Icon=/opt/vscode/resources/app/resources/linux/code.png
Exec=/opt/vscode/code
Categories=Development;IDE;" > /usr/share/applications/code.desktop

    # Cleanup
    rm -f ideaIU-${IntelliJIDEA_VERSION}.tar.gz vscode.tar.gz

    print_success "Development IDEs installed successfully!"
} 