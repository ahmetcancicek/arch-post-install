#!/bin/bash

# Make script safer
set -e

# Get script location
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source required files
source "${SCRIPT_DIR}/setup/config/messages.sh"
source "${SCRIPT_DIR}/setup/config/packages.sh"
source "${SCRIPT_DIR}/setup/config/urls.sh"
source "${SCRIPT_DIR}/setup/config/versions.sh"

# Create required directories
mkdir -p "${SCRIPT_DIR}/setup/installers"

# Load all installer scripts
for installer in "${SCRIPT_DIR}"/setup/installers/*/*.sh; do
    if [ -f "$installer" ]; then
        source "$installer"
    fi
done

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "This script must be run as root"
    exit 1
fi

# Get real user for installations
REAL_USER=$(logname || who | awk '{print $1}' | head -n 1)
if [ -z "$REAL_USER" ]; then
    print_error "Could not determine the real user"
    exit 1
fi
print_info "Installing for user: $REAL_USER"

# Main program
print_start "Arch Linux Post-Installation"

# Update system first
print_section "System Update"
print_message "Updating system packages..."
pacman -Syu --noconfirm || {
    print_failed "System update"
    exit 1
}
print_success "System updated successfully"

# Install base packages
print_section "Base System Packages"
for category in "${!base_packages[@]}"; do
    print_message "Category: $category"
    for package in ${base_packages[$category]}; do
        print_installing "$package"
        pacman -S --noconfirm "$package" || {
            print_failed "$package"
            continue
        }
        print_installed "$package"
    done
done

# Install official repository packages
print_section "Official Repository Packages"
for category in "${!official_packages[@]}"; do
    print_message "Category: $category"
    for package in ${official_packages[$category]}; do
        print_installing "$package"
        pacman -S --noconfirm "$package" || {
            print_failed "$package"
            continue
        }
        print_installed "$package"
    done
done

print_done "Arch Linux Post-Installation"