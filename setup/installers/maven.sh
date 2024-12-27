#!/bin/bash

install_maven() {
    print_message "Installing Maven..."
    cd /tmp

    wget -q "${program_urls[maven]}"
    tar xf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
    ln -sf /opt/apache-maven-${MAVEN_VERSION} /opt/maven

    # Configure Maven
    echo "# Maven Configuration
export M2_HOME=/opt/maven
export PATH=\$PATH:\$M2_HOME/bin" > /etc/profile.d/maven.sh
    chmod +x /etc/profile.d/maven.sh

    # Cleanup
    rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz

    print_success "Maven installed successfully!"
} 