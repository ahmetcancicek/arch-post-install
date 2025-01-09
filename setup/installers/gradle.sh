#!/bin/bash

install_gradle() {
    print_step "Gradle"
    cd /tmp

    # Download Gradle
    print_download "Gradle"
    wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
    
    # Install Gradle
    print_installing "Gradle"
    unzip -q gradle-${GRADLE_VERSION}-bin.zip -d /opt
    ln -sf /opt/gradle-${GRADLE_VERSION} /opt/gradle

    # Configure Gradle
    print_step "Configuring Gradle environment"
    echo "# Gradle Configuration
export GRADLE_HOME=/opt/gradle
export PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
    chmod +x /etc/profile.d/gradle.sh

    # Cleanup
    print_cleanup "temporary files"
    rm -f gradle-${GRADLE_VERSION}-bin.zip

    print_installed "Gradle"
} 