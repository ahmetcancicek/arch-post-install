#!/bin/bash

install_droidcam() {
    print_message "Installing DroidCam..."
    cd /tmp

    # Download DroidCam
    wget -q "${program_urls[droidcam]}" -O droidcam.zip || {
        print_error "Failed to download DroidCam"
        return 1
    }

    # Extract and install
    unzip -q droidcam.zip -d droidcam || {
        print_error "Failed to extract DroidCam"
        return 1
    }
    cd droidcam

    # Install client and video module
    ./install-client || {
        print_error "Failed to install DroidCam client"
        return 1
    }

    ./install-video || {
        print_error "Failed to install video module"
        return 1
    }

    # Cleanup
    cd /tmp
    rm -rf droidcam*

    print_success "DroidCam installed successfully!"
    print_info "Please restart your computer to complete the installation"
} 