#!/bin/bash

install_golang() {
    print_message "Installing Go..."
    cd /tmp

    wget -q "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
    rm -rf /usr/local/go
    tar -C /usr/local -xf go${GO_VERSION}.linux-amd64.tar.gz

    # Configure Go
    echo "# Go Configuration
export PATH=\$PATH:/usr/local/go/bin
export GOPATH=\$HOME/go" > /etc/profile.d/go.sh
    chmod +x /etc/profile.d/go.sh

    # Cleanup
    rm -f go${GO_VERSION}.linux-amd64.tar.gz

    print_success "Go installed successfully!"
} 