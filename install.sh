#!/bin/bash

# Colors for messages
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print functions
print_error() { echo -e "${RED}Error: $1${NC}"; }
print_success() { echo -e "${GREEN}Success: $1${NC}"; }
print_info() { echo -e "${BLUE}Info: $1${NC}"; }

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run as root"
    exit 1
fi

# Install git if not present
if ! command -v git >/dev/null 2>&1; then
    print_info "Installing git..."
    pacman -Sy --noconfirm git || {
        print_error "Failed to install git"
        exit 1
    }
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR" || exit 1

# Clone repository
print_info "Downloading Arch Post Install..."
git clone --depth=1 https://github.com/ahmetcancicek/arch-post-install.git || {
    print_error "Failed to clone repository"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Run installation script
print_info "Starting installation..."
cd arch-post-install || {
    print_error "Failed to enter directory"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Make script executable
chmod +x arch-post-install.sh

# Run the script
./arch-post-install.sh

# Cleanup
cd / || exit 1
rm -rf "$TEMP_DIR"

print_success "Installation complete!" 