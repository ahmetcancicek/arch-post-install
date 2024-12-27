#!/bin/bash

install_clickup() {
    print_installation_message "ClickUp"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "clickup" "clickup.AppImage"; then
        return 1
    fi

    # Installation
    mkdir -p /opt/clickup
    chmod +x clickup.AppImage
    mv clickup.AppImage /opt/clickup/
    
    # Copy icon
    cp "${SCRIPT_DIR}/icons/clickup.png" /opt/clickup/

    # Create desktop entry
    cat > /usr/share/applications/clickup.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=ClickUp
Icon=/opt/clickup/clickup.png
Exec=/opt/clickup/clickup.AppImage
Comment=ClickUp - Project Management Tool
Terminal=false
Categories=Office;ProjectManagement;
EOF

    print_installation_success "ClickUp"
    return 0
} 