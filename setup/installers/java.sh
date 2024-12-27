#!/bin/bash

install_all_java() {
    print_message "Installing Java Development Kits..."

    # Install OpenJDK (latest version)
    print_message "Installing OpenJDK..."
    install_package "jdk-openjdk"

    # Install Oracle JDK
    print_message "Installing Oracle JDK..."
    cd /tmp

    # Download and install JDK 23 (Latest)
    wget -q "${program_urls[java23]}"
    tar xf jdk-23_linux-x64_bin.tar.gz
    rm -rf /usr/lib/jvm/jdk-23
    mv jdk-23.* /usr/lib/jvm/jdk-23

    # Download and install JDK 21 (LTS)
    wget -q "${program_urls[java21]}"
    tar xf jdk-21_linux-x64_bin.tar.gz
    rm -rf /usr/lib/jvm/jdk-21
    mv jdk-21.* /usr/lib/jvm/jdk-21

    # Download and install JDK 17 (LTS)
    wget -q "${program_urls[java17]}"
    tar xf jdk-17.0.12_linux-x64_bin.tar.gz
    rm -rf /usr/lib/jvm/jdk-17
    mv jdk-17.* /usr/lib/jvm/jdk-17

    # Configure Java environment
    echo "# Oracle JDK Configuration
export JAVA_HOME=/usr/lib/jvm/jdk-23
export PATH=\$PATH:\$JAVA_HOME/bin" > /etc/profile.d/jdk.sh
    chmod +x /etc/profile.d/jdk.sh

    # Set Oracle JDK 23 as default
    archlinux-java set jdk-23

    # Cleanup
    rm -f jdk-*_linux-x64_bin.tar.gz

    print_success "Java Development Kits installed successfully!"
} 