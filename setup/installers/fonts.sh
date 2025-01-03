#!/bin/bash

install_fonts() {
    print_message "Installing fonts..."

    # Create fonts directory
    mkdir -p /usr/local/share/fonts

    # System fonts from official repositories
    local system_fonts=(
        "powerline-fonts"         # Powerline-enabled fonts
        "ttf-roboto"             # Google's Roboto
        "ttf-ubuntu-font-family"  # Ubuntu font family
        "noto-fonts"             # Google Noto fonts
        "ttf-hack"               # Clean monospace font
        "ttf-jetbrains-mono"     # Developer-focused font
        "ttf-fira-code"          # Programming font with ligatures
        "ttf-fira-mono"          # Fira Mono variant
        "ttf-fira-sans"          # Fira Sans variant
        "ttf-overpass"           # Red Hat Overpass font
    )

    # Install system fonts
    for font in "${system_fonts[@]}"; do
        install_package "$font"
    done

    # Create temporary directory for downloads
    local tmp_dir=$(mktemp -d)
    cd "$tmp_dir" || return 1

    # GitHub-hosted fonts
    print_message "Installing fonts from GitHub..."
    
    # JetBrains Mono (latest version)
    wget -q "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip"
    unzip -q JetBrainsMono-2.304.zip -d jetbrains-mono
    mkdir -p /usr/local/share/fonts/jetbrains-mono
    mv jetbrains-mono/fonts/ttf/* /usr/local/share/fonts/jetbrains-mono/

    # Inter font
    wget -q "https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip"
    unzip -q Inter-4.0.zip -d inter
    mkdir -p /usr/local/share/fonts/inter
    mv inter/Inter\ Desktop/* /usr/local/share/fonts/inter/

    # Hack font
    wget -q -O hack.zip "https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"
    unzip -q hack.zip -d hack
    mkdir -p /usr/local/share/fonts/hack
    mv hack/* /usr/local/share/fonts/hack/

    # Clear Sans
    wget -q "https://github.com/intel/clear-sans/archive/refs/heads/master.zip" -O clear-sans.zip
    unzip -q clear-sans.zip
    mkdir -p /usr/local/share/fonts/clear-sans
    mv clear-sans-master/TTF/* /usr/local/share/fonts/clear-sans/

    # Monaco
    print_message "Installing Monaco font..."
    mkdir -p /usr/local/share/fonts/monaco
    cd /usr/local/share/fonts/monaco
    wget -q "http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf"

    # MesloLGS NF (for PowerLevel10k)
    print_message "Installing MesloLGS NF font..."
    local meslo_dir="/usr/local/share/fonts/meslo-nf"
    mkdir -p "$meslo_dir"
    cd "$meslo_dir"

    local meslo_variants=(
        "Regular.ttf"
        "Bold.ttf"
        "Italic.ttf"
        "Bold%20Italic.ttf"
    )

    for variant in "${meslo_variants[@]}"; do
        wget -q "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${variant}"
    done

    # Cleanup
    rm -rf "$tmp_dir"

    # Update font cache
    fc-cache -f

    print_success "All fonts installed successfully!"
} 