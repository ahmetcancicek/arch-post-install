#!/bin/bash

install_all_java() {
    print_step "Java Development Kits"
    cd /tmp

    # Install OpenJDK
    print_installing "OpenJDK"
    install_package "jdk-openjdk"

    # Download and install Oracle JDKs
    print_download "Oracle JDK 23"
    wget -q "${program_urls[java23]}"
    print_installing "Oracle JDK 23"
    tar xf jdk-23_linux-x64_bin.tar.gz
    rm -rf /usr/lib/jvm/jdk-23
    mv jdk-23.* /usr/lib/jvm/jdk-23

    print_download "Oracle JDK 21"
    wget -q "${program_urls[java21]}"
    print_installing "Oracle JDK 21"
    tar xf jdk-21_linux-x64_bin.tar.gz
    rm -rf /usr/lib/jvm/jdk-21
    mv jdk-21.* /usr/lib/jvm/jdk-21

    print_download "Oracle JDK 17"
    wget -q "${program_urls[java17]}"
    print_installing "Oracle JDK 17"
    tar xf jdk-17.0.12_linux-x64_bin.tar.gz
    rm -rf /usr/lib/jvm/jdk-17
    mv jdk-17.* /usr/lib/jvm/jdk-17

    # Configure Java environment
    print_step "Configuring Java environment"
    echo "# Oracle JDK Configuration
export JAVA_HOME=/usr/lib/jvm/jdk-23
export PATH=\$PATH:\$JAVA_HOME/bin" > /etc/profile.d/jdk.sh
    chmod +x /etc/profile.d/jdk.sh

    # Set default Java version
    archlinux-java set jdk-23

    # Cleanup
    print_cleanup "temporary files"
    rm -f jdk-*_linux-x64_bin.tar.gz

    print_installed "Java Development Kits"
} 