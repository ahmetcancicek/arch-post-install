#!/bin/bash

install_zotero() {
    print_step "Zotero"
    cd /tmp

    # Download Zotero
    print_download "Zotero"
    wget -q "${program_urls[zotero]}" -O zotero.tar.bz2
    
    # Install Zotero
    print_installing "Zotero"
    tar xjf zotero.tar.bz2
    rm -rf /opt/zotero
    mv Zotero_linux-x86_64 /opt/zotero

    # Create symbolic link
    ln -sf /opt/zotero/zotero /usr/local/bin/zotero

    # Create desktop entry
    echo "[Desktop Entry]
Name=Zotero
Comment=Open-source reference manager
Exec=/opt/zotero/zotero
Icon=/opt/zotero/chrome/icons/default/default256.png
Type=Application
Terminal=false
Categories=Office;Bibliography;Science;" > /usr/share/applications/zotero.desktop

    # Cleanup
    print_cleanup "temporary files"
    rm -f zotero.tar.bz2

    print_installed "Zotero"
} 