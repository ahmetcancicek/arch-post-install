#!/bin/bash

install_zsh() {
    print_step "ZSH"

    # Install ZSH and dependencies
    print_installing "ZSH and dependencies"
    local zsh_packages=(
        "zsh"
        "zsh-completions"
        "zsh-syntax-highlighting"
        "zsh-autosuggestions"
    )

    for package in "${zsh_packages[@]}"; do
        install_package "$package"
    done

    # Install Oh My Zsh
    print_step "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Install Powerlevel10k theme
    print_step "Installing Powerlevel10k theme"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    # Configure ZSH
    print_step "Configuring ZSH"
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

    # Set ZSH as default shell
    print_step "Setting ZSH as default shell"
    chsh -s /bin/zsh

    print_installed "ZSH"
    print_info "Please log out and log back in to start using ZSH"
} 