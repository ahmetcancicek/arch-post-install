#!/bin/bash

install_development_tools() {
    print_step "Development Tools"

    # Install base packages
    print_step "Installing base packages"
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

    # Configure Docker
    print_step "Configuring Docker service"
    systemctl enable --now docker.service
    usermod -aG docker "$(logname)"

    print_installed "Development Tools"
} 