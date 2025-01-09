#!/bin/bash

install_droidcam() {
    print_step "DroidCam"
    cd /tmp

    # Download DroidCam
    print_download "DroidCam"
    wget -q "${program_urls[droidcam]}" -O droidcam.zip || {
        print_error "Failed to download DroidCam"
        return 1
    }

    # Extract files
    print_installing "DroidCam"
    unzip -q droidcam.zip -d droidcam || {
        print_error "Failed to extract DroidCam"
        return 1
    }
    cd droidcam

    # Install client and video module
    print_step "Installing DroidCam client"
    ./install-client || {
        print_error "Failed to install DroidCam client"
        return 1
    }

    print_step "Installing video module"
    ./install-video || {
        print_error "Failed to install video module"
        return 1
    }

    # Cleanup
    print_cleanup "temporary files"
    cd /tmp
    rm -rf droidcam*

    print_installed "DroidCam"
    print_info "Please restart your computer to complete the installation"
} 