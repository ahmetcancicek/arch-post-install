#!/bin/bash

install_golang() {
    print_step "Go"
    cd /tmp

    # Download Go
    print_download "Go"
    wget -q "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
    
    # Install Go
    print_installing "Go"
    rm -rf /usr/local/go
    tar -C /usr/local -xf go${GO_VERSION}.linux-amd64.tar.gz

    # Configure Go environment
    print_step "Configuring Go environment"
    echo "# Go Configuration
export PATH=\$PATH:/usr/local/go/bin
export GOPATH=\$HOME/go" > /etc/profile.d/go.sh
    chmod +x /etc/profile.d/go.sh

    # Cleanup
    print_cleanup "temporary files"
    rm -f go${GO_VERSION}.linux-amd64.tar.gz

    print_installed "Go"
} 