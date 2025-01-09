#!/bin/bash

install_drivers() {
    print_step "System Drivers"

    # Install Bluetooth drivers
    print_step "Installing Bluetooth drivers"
    local bluetooth_packages=(
        "bluez"
        "bluez-utils"
        "blueman"
    )

    for package in "${bluetooth_packages[@]}"; do
        install_package "$package"
    done

    # Configure Bluetooth
    print_step "Configuring Bluetooth service"
    systemctl enable --now bluetooth.service

    print_step "Configuring Bluetooth settings"
    if command -v hciconfig &> /dev/null; then
        hciconfig hci0 noscan
    fi

    print_installed "System Drivers"
}

# NVIDIA driver installation function
install_nvidia_drivers() {
    print_step "NVIDIA Drivers"
    
    # Check for NVIDIA GPU
    if ! lspci | grep -i nvidia &> /dev/null; then
        print_error "No NVIDIA GPU detected"
        return 1
    fi

    # Install NVIDIA packages
    print_installing "NVIDIA packages"
    local nvidia_packages=(
        "nvidia"                  # Main driver
        "nvidia-utils"           # Utilities
        "nvidia-settings"        # Settings GUI
        "lib32-nvidia-utils"     # 32-bit support
        "opencl-nvidia"          # OpenCL support
        "cuda"                   # CUDA support
    )

    for package in "${nvidia_packages[@]}"; do
        install_package "$package"
    done

    # Configure NVIDIA
    print_step "Configuring NVIDIA modules"
    
    # Create Xorg config directory
    if [ ! -d "/etc/X11/xorg.conf.d" ]; then
        mkdir -p /etc/X11/xorg.conf.d
    fi

    # Enable DRM kernel mode
    if [ -f "/etc/mkinitcpio.conf" ]; then
        sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        mkinitcpio -P
    fi

    # Enable early loading
    if [ -d "/etc/modprobe.d" ]; then
        echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf
    fi

    print_installed "NVIDIA Drivers"
    print_info "Please reboot to complete NVIDIA driver installation"
    print_info "After reboot, use 'nvidia-settings' to configure your display"
} 