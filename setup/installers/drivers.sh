#!/bin/bash

install_drivers() {
    print_message "Installing system drivers..."

    # Bluetooth drivers and utilities
    local bluetooth_packages=(
        "bluez"
        "bluez-utils"
        "blueman"
    )

    for package in "${bluetooth_packages[@]}"; do
        install_package "$package"
    done

    # Enable and start bluetooth service
    print_message "Enabling bluetooth service..."
    systemctl enable --now bluetooth.service

    # Configure bluetooth visibility
    print_message "Configuring bluetooth settings..."
    if command -v hciconfig &> /dev/null; then
        hciconfig hci0 noscan
    fi

    print_success "System drivers installed successfully!"
}

# NVIDIA driver installation function (commented out by default)
# Uncomment and modify based on your GPU model
#install_nvidia_drivers() {
#    print_message "Installing NVIDIA drivers..."
#    
#    # Check if NVIDIA GPU exists
#    if ! lspci | grep -i nvidia &> /dev/null; then
#        print_error "No NVIDIA GPU detected in the system!"
#        return 1
#    fi
#
#    # Basic NVIDIA packages
#    local nvidia_packages=(
#        "nvidia"                  # Main NVIDIA driver
#        "nvidia-utils"           # NVIDIA driver utilities
#        "nvidia-settings"        # NVIDIA settings GUI tool
#        "lib32-nvidia-utils"     # 32-bit support (for gaming)
#        "opencl-nvidia"          # OpenCL support
#        "cuda"                   # CUDA support (optional)
#    )
#
#    # Optional packages for specific use cases
#    #local optional_packages=(
#    #    "nvidia-dkms"           # For custom kernels
#    #    "nvidia-prime"          # For laptops with hybrid graphics
#    #    "bbswitch"              # For Optimus laptops
#    #)
#
#    # Install main NVIDIA packages
#    for package in "${nvidia_packages[@]}"; do
#        install_package "$package"
#    done
#
#    # Enable services and modules
#    print_message "Configuring NVIDIA services..."
#    
#    # Create Xorg configuration
#    if [ ! -d "/etc/X11/xorg.conf.d" ]; then
#        mkdir -p /etc/X11/xorg.conf.d
#    fi
#
#    # Enable DRM kernel mode setting
#    if [ -f "/etc/mkinitcpio.conf" ]; then
#        sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
#        mkinitcpio -P
#    fi
#
#    # Enable early loading
#    if [ -d "/etc/modprobe.d" ]; then
#        echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf
#    fi
#
#    print_success "NVIDIA drivers installed successfully!"
#    print_warning "A system reboot is required for the changes to take effect."
#    print_warning "After reboot, use 'nvidia-settings' to configure your display settings."
#} 