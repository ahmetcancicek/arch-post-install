#!/bin/bash

install_spring() {
    print_step "Spring Boot CLI"
    cd /tmp

    # Download Spring Boot CLI
    print_download "Spring Boot CLI"
    wget -q "${program_urls[spring]}"
    
    # Install Spring Boot
    print_installing "Spring Boot CLI"
    tar -xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
    rm -rf /opt/spring-boot-cli
    mv spring-${SPRING_VERSION} /opt/spring-boot-cli

    # Configure Spring Boot environment
    print_step "Configuring Spring Boot environment"
    echo "# Spring Boot CLI Configuration
export SPRING_HOME=/opt/spring-boot-cli
export PATH=\$PATH:\$SPRING_HOME/bin" > /etc/profile.d/spring.sh
    chmod +x /etc/profile.d/spring.sh

    # Cleanup
    print_cleanup "temporary files"
    rm -f spring-boot-cli-${SPRING_VERSION}-bin.tar.gz

    print_installed "Spring Boot CLI"
} 