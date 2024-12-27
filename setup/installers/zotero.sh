#!/bin/bash

install_zotero() {
    print_message "Installing Zotero..."
    cd /tmp

    # Download Zotero
    wget -q "${program_urls[zotero]}" -O zotero.tar.bz2 || {
        print_error "Failed to download Zotero"
        return 1
    }

    # Extract archive
    tar -xjf zotero.tar.bz2 || {
        print_error "Failed to extract Zotero"
        return 1
    }

    # Install to /opt
    rm -rf /opt/zotero
    mv Zotero_linux-x86_64 /opt/zotero || {
        print_error "Failed to install Zotero to /opt"
        return 1
    }

    # Create desktop entry
    cat > /usr/share/applications/zotero.desktop << EOF
[Desktop Entry]
Name=Zotero
Exec=/opt/zotero/zotero
Icon=/opt/zotero/icons/icon128.png
Type=Application
Terminal=false
Categories=Office;Bibliography;
MimeType=text/plain;x-scheme-handler/zotero;application/x-research-info-systems;text/x-research-info-systems;text/ris;application/x-endnote-refer;application/x-inst-for-Scientific-info;application/mods+xml;application/rdf+xml;application/x-bibtex;text/x-bibtex;application/marc;application/vnd.citationstyles.style+xml
EOF

    # Cleanup
    rm -f zotero.tar.bz2

    print_success "Zotero installed successfully!"
} 