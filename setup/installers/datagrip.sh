#!/bin/bash

install_datagrip() {
    print_step "DataGrip"
    cd /tmp

    # Download DataGrip
    print_download "DataGrip"
    wget -q "${program_urls[datagrip]}"
    
    # Install DataGrip
    print_installing "DataGrip"
    tar -xf datagrip-${DataGrip_VERSION}.tar.gz
    rm -rf /opt/datagrip
    mv DataGrip-* /opt/datagrip

    # Create symbolic link
    ln -sf /opt/datagrip/bin/datagrip.sh /usr/local/bin/datagrip

    # Create desktop entry
    echo "[Desktop Entry]
Type=Application
Name=DataGrip
Icon=/opt/datagrip/bin/datagrip.svg
Exec=/opt/datagrip/bin/datagrip.sh
Categories=Development;IDE;Database;
Comment=Database IDE by JetBrains" > /usr/share/applications/jetbrains-datagrip.desktop

    # Cleanup
    print_cleanup "temporary files"
    rm -f datagrip-${DataGrip_VERSION}.tar.gz

    print_installed "DataGrip"
} 