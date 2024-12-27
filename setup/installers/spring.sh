#!/bin/bash

install_spring() {
    print_message "Installing Spring Boot CLI..."
    cd /tmp

    # Download Spring Boot CLI
    wget -q "${program_urls[spring]}"
    tar -xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
    rm -rf /opt/spring-boot-cli
    mv spring-${SPRING_VERSION} /opt/spring-boot-cli

    # Configure Spring Boot environment
    echo "# Spring Boot CLI Configuration
export SPRING_HOME=/opt/spring-boot-cli
export PATH=\$PATH:\$SPRING_HOME/bin" > /etc/profile.d/spring.sh
    chmod +x /etc/profile.d/spring.sh

    # Cleanup
    rm -f spring-boot-cli-${SPRING_VERSION}-bin.tar.gz

    print_success "Spring Boot CLI installed successfully!"
} 