#!/bin/bash

# All program download URLs
declare -A program_urls=(
    # JetBrains IDEs
    [intellij]="https://download.jetbrains.com/idea/ideaIU-${IntelliJIDEA_VERSION}.tar.gz"
    [datagrip]="https://download.jetbrains.com/datagrip/datagrip-${DataGrip_VERSION}.tar.gz"
    [goland]="https://download.jetbrains.com/go/goland-${GoLand_VERSION}.tar.gz"

    # Development Tools
    [vscode]="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
    [postman]="https://dl.pstmn.io/download/latest/linux64"
    [maven]="https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
    [gradle]="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
    [spring]="https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz"
    [golang]="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"

    # Java Development Kits
    [java23]="https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.tar.gz"
    [java21]="https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz"
    [java17]="https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-x64_bin.tar.gz"

    # Applications
    [zoom]="https://zoom.us/client/${ZOOM_VERSION}/zoom_x86_64.pkg.tar.xz"
    [anki]="https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst"
    [clickup]="https://desktop.clickup.com/linux"
    [cursor]="https://downloader.cursor.sh/linux/appImage/x64"
    [droidcam]="https://files.dev47apps.net/linux/droidcam_${DROIDCAM_VERSION}.zip"
    [zotero]="https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=${ZOTERO_VERSION}"
) 