#!/bin/bash

install_gradle() {
    print_message "Installing Gradle..."
    cd /tmp

    wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
    unzip -q gradle-${GRADLE_VERSION}-bin.zip -d /opt
    ln -sf /opt/gradle-${GRADLE_VERSION} /opt/gradle

    # Configure Gradle
    echo "# Gradle Configuration
export GRADLE_HOME=/opt/gradle
export PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
    chmod +x /etc/profile.d/gradle.sh

    # Cleanup
    rm -f gradle-${GRADLE_VERSION}-bin.zip

    print_success "Gradle installed successfully!"
} 