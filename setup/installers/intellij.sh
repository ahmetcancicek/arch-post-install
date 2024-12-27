#!/bin/bash

install_intellij() {
    print_message "Installing IntelliJ IDEA Ultimate..."
    cd /tmp
    
    wget -q "${program_urls[intellij]}"
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

    # Cleanup
    rm -f ideaIU-${IntelliJIDEA_VERSION}.tar.gz

    print_success "IntelliJ IDEA Ultimate installed successfully!"
} 