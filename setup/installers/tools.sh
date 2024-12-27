#!/bin/bash

install_development_tools() {
    print_message "Installing development tools..."

    # Install base packages from repository
    local base_packages=(
        "git"
        "vim"
        "docker"
        "docker-compose"
        "nodejs"
        "npm"
    )

    for package in "${base_packages[@]}"; do
        install_package "$package"
    done

    # Enable Docker service
    systemctl enable --now docker.service
    usermod -aG docker "$(logname)"

    print_success "Development tools installed successfully!"
} 