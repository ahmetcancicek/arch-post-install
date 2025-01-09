#!/bin/bash

install_development_ides() {
    print_step "Development IDEs"
    cd /tmp
    
    # Install IntelliJ IDEA Ultimate
    print_step "Installing IntelliJ IDEA Ultimate"
    print_download "IntelliJ IDEA"
    wget -q "https://download.jetbrains.com/idea/ideaIU-${IntelliJIDEA_VERSION}.tar.gz"
    
    print_installing "IntelliJ IDEA"
    tar -xf ideaIU-${IntelliJIDEA_VERSION}.tar.gz
    rm -rf /opt/idea
    mv idea-IU-* /opt/idea
    ln -sf /opt/idea/bin/idea.sh /usr/local/bin/idea

    # Create desktop entry for IntelliJ
    echo "[Desktop Entry]
Type=Application
Name=IntelliJ IDEA Ultimate
Icon=/opt/idea/bin/idea.svg
Exec=/opt/idea/bin/idea.sh
Categories=Development;IDE;" > /usr/share/applications/jetbrains-idea.desktop
    
    # Install VSCode
    print_step "Installing Visual Studio Code"
    print_download "VSCode"
    wget -q "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" -O vscode.tar.gz
    
    print_installing "VSCode"
    tar -xf vscode.tar.gz
    rm -rf /opt/vscode
    mv VSCode-linux-x64 /opt/vscode
    ln -sf /opt/vscode/bin/code /usr/local/bin/code

    # Create desktop entry for VSCode
    echo "[Desktop Entry]
Type=Application
Name=Visual Studio Code
Icon=/opt/vscode/resources/app/resources/linux/code.png
Exec=/opt/vscode/code
Categories=Development;IDE;" > /usr/share/applications/code.desktop

    # Cleanup
    print_cleanup "temporary files"
    rm -f ideaIU-${IntelliJIDEA_VERSION}.tar.gz vscode.tar.gz

    print_installed "Development IDEs"
} 