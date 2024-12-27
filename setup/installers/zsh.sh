#!/bin/bash

install_zsh() {
    print_message "Installing ZSH + Oh My ZSH + Powerlevel10k..."
    
    # Get real user info
    REAL_USER=$(get_real_user)
    if [ -z "$REAL_USER" ]; then
        print_error "Could not determine the real user"
        return 1
    fi

    REAL_HOME=$(get_real_home "$REAL_USER")
    if [ ! -d "$REAL_HOME" ]; then
        print_error "Home directory $REAL_HOME does not exist"
        return 1
    fi

    # Install ZSH
    print_info "Installing ZSH"
    pacman -Sy --noconfirm zsh || {
        print_error "Failed to install ZSH"
        return 1
    }

    # Set ZSH as default shell
    print_info "Setting ZSH as default shell"
    chsh -s /usr/bin/zsh "$REAL_USER" || {
        print_error "Failed to set ZSH as default shell"
        return 1
    }

    # Install Oh My ZSH
    print_info "Installing Oh My ZSH"
    su -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended" - "$REAL_USER" || {
        print_error "Failed to install Oh My ZSH"
        return 1
    }

    # Install required fonts
    print_info "Installing required fonts"
    pacman -S --noconfirm ttf-meslo-nerd-font-powerlevel10k || {
        print_error "Failed to install fonts"
        return 1
    }

    # Install Powerlevel10k theme
    print_info "Installing Powerlevel10k theme"
    su - "$REAL_USER" -c "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${REAL_HOME}/.oh-my-zsh/custom/themes/powerlevel10k" || {
        print_error "Failed to install Powerlevel10k theme"
        return 1
    }

    # Install plugins
    print_info "Installing ZSH plugins"
    su - "$REAL_USER" -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git ${REAL_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || {
        print_error "Failed to install autosuggestions plugin"
        return 1
    }

    su - "$REAL_USER" -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${REAL_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" || {
        print_error "Failed to install syntax highlighting plugin"
        return 1
    }

    # Configure .zshrc
    print_info "Configuring .zshrc"
    su - "$REAL_USER" -c "sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/' ${REAL_HOME}/.zshrc"
    su - "$REAL_USER" -c "sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ${REAL_HOME}/.zshrc"

    print_success "ZSH installed successfully!"
    print_info "Please log out and log back in to start using ZSH"
    print_info "After logging back in, run 'p10k configure' to setup Powerlevel10k theme"
} 