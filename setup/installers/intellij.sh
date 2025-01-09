#!/bin/bash

install_intellij() {
    print_step "IntelliJ IDEA Ultimate"
    cd /tmp
    
    # Download IntelliJ
    print_download "IntelliJ IDEA"
    wget -q "${program_urls[intellij]}"
    
    # Install IntelliJ
    print_installing "IntelliJ IDEA"
    tar -xf ideaIU-${IntelliJIDEA_VERSION}.tar.gz
    rm -rf /opt/idea
    mv idea-IU-* /opt/idea

    # Create symbolic link
    ln -sf /opt/idea/bin/idea.sh /usr/local/bin/idea

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=IntelliJ IDEA Ultimate
Icon=/opt/idea/bin/idea.svg
Exec=/opt/idea/bin/idea.sh
Categories=Development;IDE;" > /usr/share/applications/jetbrains-idea.desktop

    # Cleanup
    print_cleanup "temporary files"
    rm -f ideaIU-${IntelliJIDEA_VERSION}.tar.gz

    print_installed "IntelliJ IDEA Ultimate"
} 