#!/bin/bash

install_maven() {
    print_step "Maven"
    cd /tmp

    # Download Maven
    print_download "Maven"
    wget -q "${program_urls[maven]}"
    
    # Install Maven
    print_installing "Maven"
    tar xf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
    ln -sf /opt/apache-maven-${MAVEN_VERSION} /opt/maven

    # Configure Maven
    print_step "Configuring Maven environment"
    echo "# Maven Configuration
export M2_HOME=/opt/maven
export PATH=\$PATH:\$M2_HOME/bin" > /etc/profile.d/maven.sh
    chmod +x /etc/profile.d/maven.sh

    # Cleanup
    print_cleanup "temporary files"
    rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz

    print_installed "Maven"
} 