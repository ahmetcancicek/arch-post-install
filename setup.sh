#! /bin/bash

###################
# Color Variables #
###################
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

###################
# Import Versions #
###################
source "$(dirname "$0")/versions.sh"

###################
# Root Control    #
###################
if [ "$(id -u)" != 0 ]; then
  printf "${RED}"
  cat <<EOL
========================================================================
You are not root! This script must be run as root!
========================================================================
EOL
  printf "${RESET}"
  exit 1
fi

########################
# Update               #
########################
printf "\n${GREEN}========================Installing Updating========================${RESET}\n"
pacman -Syu --noconfirm
printf "${GREEN}========================Updated successfully!========================${RESET}\n"


########################
# Software Lists       #
########################
# Base system packages for core functionality
base_system_packages=(
    # System Core
    "linux-headers"
    "linux-lts-headers"
    "base-devel"
    
    # System Utilities
    "htop"
    "tree"
    "wget"
    "usbutils"
    "ntfsprogs"
    "dosfstools"
    "dialog"
    "unzip"
    "wl-clipboard"
    "sed"
    "coreutils"
    "zstd"
)

########################
# Official Repository #
########################
declare -A official_packages=(
  [base]="tree curl wget htop usbutils base-devel ntfsprogs dosfstools dialog unzip wl-clipboard sed coreutils"
  [internet]="firefox chromium"
  [multimedia]="vlc gimp kdenlive krita inkscape gnome-sound-recorder"
  [development]="git vim docker docker-compose nodejs npm jdk-openjdk"
  [utilities]="keepassxc virtualbox gnome-boxes terminator gparted timeshift"
  [communication]="thunderbird"
  [office]="libreoffice"
)

########################
# AUR Programs         #
########################
declare -A aur_packages=(
  [browsers]="google-chrome microsoft-edge-stable brave-bin"
  [development]="visual-studio-code-bin android-tools"
  [utilities]="dropbox pcloud-drive webapp-manager galaxybudsclient-bin"
  [system]="snapd"
)

########################
# Snap Programs        #
########################
declare -A snap_packages=(
  [utilities]="raindrop"
)

########################
# Flatpak Programs     #
########################
declare -A flatpak_packages=(
  [multimedia]="com.obsproject.Studio"
)

########################
# Web Download Programs #
########################
declare -A web_programs=(
    [intellij]="https://download.jetbrains.com/idea/ideaIU-${IntelliJIDEA_VERSION}.tar.gz"
    [datagrip]="https://download.jetbrains.com/datagrip/datagrip-${DataGrip_VERSION}.tar.gz"
    [goland]="https://download.jetbrains.com/go/goland-${GoLand_VERSION}.tar.gz"
    [maven]="https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
    [gradle]="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
    [springboot]="https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz"
    [zoom]="https://zoom.us/client/${ZOOM_VERSION}/zoom_x86_64.pkg.tar.xz"
    [zotero]="https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=${ZOTERO_VERSION}"
    [cursor]="https://downloader.cursor.sh/linux/appImage/x64"
    [anki]="https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst"
    [droidcam]="https://files.dev47apps.net/linux/droidcam_${DROIDCAM_VERSION}.zip"
    [java17]="https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz"
    [java21]="https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz"
    [java23]="https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.tar.gz"
    [clickup]="https://desktop.clickup.com/linux"
)

########################
# Helper Functions     #
########################
before_install_message() {
    echo "Preparing to install $1..."
}

# Function to display a success message in green
success_message() {
    echo -e "${GREEN}Installation of $1 was successful!${RESET}"
}

# Function to display a failure message in red
failure_message() {
    echo -e "${RED}Installation of $1 failed!${RESET}"
}

# Check and install AUR helper (yay)
check_and_install_aur() {
    if ! command -v yay &> /dev/null; then
        echo "AUR helper (yay) is not installed. Installing..."
        # Get actual username even when running as root
        USER=$(logname)
        # Install yay using the actual user
        sudo -u $USER bash -c '\
            cd /tmp && \
            rm -rf yay && \
            git clone https://aur.archlinux.org/yay.git && \
            cd yay && \
            makepkg -si --noconfirm
        '
        if [ $? -eq 0 ]; then
            success_message "AUR helper (yay)"
        else
            failure_message "AUR helper (yay)"
            exit 1
        fi
    else
        echo "AUR helper (yay) is already installed."
    fi
}

# Install Official Packages
install_official_packages() {
  for category in "${!official_packages[@]}"; do
    printf "\n${GREEN}Installing ${category} packages...${RESET}\n"
    pacman -S --noconfirm ${official_packages[$category]}
  done
}

# Install AUR Packages
install_aur_packages() {
  for category in "${!aur_packages[@]}"; do
    printf "\n${GREEN}Installing ${category} AUR packages...${RESET}\n"
    sudo -u $USER bash -c "yes | yay -S ${aur_packages[$category]}"
  done
}

# Install Snap Packages
install_snap_packages() {
  for category in "${!snap_packages[@]}"; do
    printf "\n${GREEN}Installing ${category} Snap packages...${RESET}\n"
    sudo -u $USER bash -c "snap install ${snap_packages[$category]}"
  done
}

# Install Flatpak Packages
install_flatpak_packages() {
  for category in "${!flatpak_packages[@]}"; do
    printf "\n${GREEN}Installing ${category} Flatpak packages...${RESET}\n"
    flatpak install -y ${flatpak_packages[$category]}
  done
}

# Install base system packages
install_base_system_packages() {
    printf "\n${GREEN}Installing base system packages...${RESET}\n"
    for package in "${base_system_packages[@]}"; do
        before_install_message "$package"
        pacman -S --noconfirm "$package"
        if [ $? -eq 0 ]; then
            success_message "$package"
        else
            failure_message "$package"
        fi
    done
    printf "${GREEN}Base system packages installation completed!${RESET}\n"
}

download_from_web_programs() {
    local program_key=$1
    local output_file=$2
    
    if [[ -z "${web_programs[$program_key]}" ]]; then
        printf "${RED}No URL found for $program_key${RESET}\n"
        return 1
    fi
    
    if ! wget "${web_programs[$program_key]}" -O "$output_file"; then
        printf "${RED}Download failed for $program_key${RESET}\n"
        return 1
    fi
    
    return 0
}

install_intellij_idea() {
    printf "\n${GREEN}Installing IntelliJ IDEA...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "intellij" "ideaIU.tar.gz"; then
        return 1
    fi
    
    # Installation
    tar -xf ideaIU.tar.gz -C /opt || return 1
    # Keep version number in folder name
    mv /opt/idea-IU-* /opt/idea-IU-${IntelliJIDEA_VERSION} || return 1
    # Create symbolic link to version-specific folder
    ln -sf /opt/idea-IU-${IntelliJIDEA_VERSION} /opt/idea
    # Create symbolic link to binary
    ln -sf /opt/idea/bin/idea.sh /usr/local/bin/idea

    # Create desktop entry
    cat > /usr/share/applications/jetbrains-idea.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate Edition
Icon=/opt/idea/bin/idea.svg
Exec=/opt/idea/bin/idea.sh %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
StartupNotify=true
EOF

    # Cleanup
    rm -f ideaIU.tar.gz
    
    printf "${GREEN}IntelliJ IDEA installation completed!${RESET}\n"
    return 0
}

install_datagrip() {
    printf "\n${GREEN}Installing DataGrip...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "datagrip" "datagrip.tar.gz"; then
        return 1
    fi
    
    # Installation
    tar -xf datagrip.tar.gz -C /opt || return 1
    # Keep version number in folder name
    mv /opt/DataGrip-* /opt/datagrip-${DataGrip_VERSION} || return 1
    # Create symbolic link to version-specific folder
    ln -sf /opt/datagrip-${DataGrip_VERSION} /opt/datagrip
    # Create symbolic link to binary
    ln -sf /opt/datagrip/bin/datagrip.sh /usr/local/bin/datagrip

    # Create desktop entry
    cat > /usr/share/applications/datagrip.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=DataGrip
Icon=/opt/datagrip/bin/datagrip.svg
Exec=/opt/datagrip/bin/datagrip.sh
Comment=Database IDE for SQL
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-datagrip
StartupNotify=true
EOF

    # Cleanup
    rm -f datagrip.tar.gz
    
    printf "${GREEN}DataGrip installation completed!${RESET}\n"
    return 0
}

install_goland() {
    printf "\n${GREEN}Installing GoLand...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "goland" "goland.tar.gz"; then
        return 1
    fi

    # Installation
    tar -xf goland.tar.gz -C /opt || return 1
    # Keep version number in folder name
    mv /opt/GoLand-* /opt/goland-${GoLand_VERSION} || return 1
    # Create symbolic link to version-specific folder
    ln -sf /opt/goland-${GoLand_VERSION} /opt/goland
    # Create symbolic link to binary
    ln -sf /opt/goland/bin/goland.sh /usr/local/bin/goland

    # Create desktop entry
    cat > /usr/share/applications/goland.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=GoLand
Icon=/opt/goland/bin/goland.svg
Exec=/opt/goland/bin/goland.sh
Comment=Go IDE
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-goland
StartupNotify=true
EOF 

    # Cleanup
    rm -f goland.tar.gz
    
    printf "${GREEN}GoLand installation completed!${RESET}\n"
    return 0
}   

install_maven() {
    printf "\n${GREEN}Installing Maven...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "maven" "maven.tar.gz"; then
        return 1
    fi

    # Installation
    tar -xf maven.tar.gz -C /opt || return 1
    # Keep version number in folder name
    mv /opt/apache-maven-* /opt/maven-${MAVEN_VERSION} || return 1
    # Create symbolic link to version-specific folder
    ln -sf /opt/maven-${MAVEN_VERSION} /opt/maven
    # Create symbolic link to /usr/local/bin
    ln -sf /opt/maven/bin/mvn /usr/local/bin/mvn

    # Maven configuration
    cat > /etc/profile.d/maven.sh << EOF
# Maven Configuration
export M2_HOME=/opt/maven
export PATH=\${M2_HOME}/bin:\${PATH}
# Auto-detect Java version
export JAVA_HOME=\$(readlink -f /usr/bin/java | sed 's:/bin/java::')
EOF
    chmod +x /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh

    # Cleanup
    rm -f maven.tar.gz
    
    if mvn -version > /dev/null 2>&1; then
        printf "${GREEN}Maven installation completed!${RESET}\n"
        return 0
    else
        printf "${RED}Maven installation failed!${RESET}\n"
        return 1
    fi
}

install_gradle() {
    printf "\n${GREEN}Installing Gradle...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "gradle" "gradle.zip"; then
        return 1
    fi

    # Installation
    unzip gradle.zip -d /opt || return 1
    mv /opt/gradle-* /opt/gradle-${GRADLE_VERSION} || return 1
    ln -sf /opt/gradle-${GRADLE_VERSION} /opt/gradle
    ln -sf /opt/gradle/bin/gradle /usr/local/bin/gradle

    # Add Gradle environment variables
    cat > /etc/profile.d/gradle.sh << EOF
export GRADLE_HOME=/opt/gradle
export PATH=\${GRADLE_HOME}/bin:\${PATH}
EOF
    chmod +x /etc/profile.d/gradle.sh
    source /etc/profile.d/gradle.sh

    # Cleanup
    rm -f gradle.zip
    
    if gradle -v > /dev/null 2>&1; then
        printf "${GREEN}Gradle installation completed!${RESET}\n"
        return 0
    else
        printf "${RED}Gradle installation failed!${RESET}\n"
        return 1
    fi
}

install_springboot() {
    printf "\n${GREEN}Installing Spring Boot CLI...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "springboot" "springboot.tar.gz"; then
        return 1
    fi

    # Installation
    tar -xf springboot.tar.gz -C /opt || return 1
    mv /opt/spring-boot-cli-* /opt/spring-boot-cli-${SPRING_VERSION} || return 1
    ln -sf /opt/spring-boot-cli-${SPRING_VERSION} /opt/spring-boot-cli
    ln -sf /opt/spring-boot-cli/bin/spring /usr/local/bin/spring

    # Add Spring Boot CLI environment variables
    cat > /etc/profile.d/springboot.sh << EOF
export SPRING_HOME=/opt/spring-boot-cli
export PATH=\${SPRING_HOME}/bin:\${PATH}
EOF
    chmod +x /etc/profile.d/springboot.sh
    source /etc/profile.d/springboot.sh

    # Cleanup
    rm -f springboot.tar.gz

    if spring --version > /dev/null 2>&1; then
        printf "${GREEN}Spring Boot CLI installation completed!${RESET}\n"
        return 0
    else
        printf "${RED}Spring Boot CLI installation failed!${RESET}\n"
        return 1
    fi
}

install_java17() {
    printf "\n${GREEN}Installing Java 17...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "java17" "java17.tar.gz"; then
        return 1
    fi

    # Installation
    tar -xf java17.tar.gz -C /usr/lib/jvm || return 1
    mv /usr/lib/jvm/jdk-17* /usr/lib/jvm/jdk-17 || return 1
    ln -sf /usr/lib/jvm/jdk-17 /usr/lib/jvm/java-17
    
    # Add Java environment variables
    if ! grep -q "JAVA_17_HOME" /etc/profile.d/jdk.sh 2>/dev/null; then
        cat >> /etc/profile.d/jdk.sh << EOF
# Java 17 Configuration
export JAVA_17_HOME=/usr/lib/jvm/java-17
EOF
    fi
    chmod +x /etc/profile.d/jdk.sh
    source /etc/profile.d/jdk.sh
    
    # Cleanup
    rm -f java17.tar.gz
    printf "${GREEN}Java 17 installation completed!${RESET}\n"
    return 0
}

install_java21() {
    printf "\n${GREEN}Installing Java 21...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "java21" "java21.tar.gz"; then
        return 1
    fi

    # Installation
    tar -xf java21.tar.gz -C /usr/lib/jvm || return 1
    mv /usr/lib/jvm/jdk-21* /usr/lib/jvm/jdk-21 || return 1
    ln -sf /usr/lib/jvm/jdk-21 /usr/lib/jvm/java-21
    
    # Add Java environment variables
    if ! grep -q "JAVA_21_HOME" /etc/profile.d/jdk.sh 2>/dev/null; then
        cat >> /etc/profile.d/jdk.sh << EOF
# Java 21 Configuration
export JAVA_21_HOME=/usr/lib/jvm/java-21
EOF
    fi
    chmod +x /etc/profile.d/jdk.sh
    source /etc/profile.d/jdk.sh
    
    # Cleanup
    rm -f java21.tar.gz
    printf "${GREEN}Java 21 installation completed!${RESET}\n"
    return 0
}

install_java23() {
    printf "\n${GREEN}Installing Java 23...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "java23" "java23.tar.gz"; then
        return 1
    fi

    # Installation
    tar -xf java23.tar.gz -C /usr/lib/jvm || return 1
    mv /usr/lib/jvm/jdk-23* /usr/lib/jvm/jdk-23 || return 1
    ln -sf /usr/lib/jvm/jdk-23 /usr/lib/jvm/java-23
    
    # Add Java environment variables
    if ! grep -q "JAVA_23_HOME" /etc/profile.d/jdk.sh 2>/dev/null; then
        cat >> /etc/profile.d/jdk.sh << EOF
# Java 23 Configuration
export JAVA_23_HOME=/usr/lib/jvm/java-23
EOF
    fi
    chmod +x /etc/profile.d/jdk.sh
    source /etc/profile.d/jdk.sh
    
    # Set Java 23 as default
    archlinux-java set java-23

    # Cleanup
    rm -f java23.tar.gz

    if java -version 2>&1 | grep -q "version \"23"; then
        printf "${GREEN}Java 23 installation completed and set as default!${RESET}\n"
        return 0
    else
        printf "${RED}Java 23 installation or default setting failed!${RESET}\n"
        return 1
    fi
}

# Install all Java versions and set Java 23 as default
install_all_java() {
    install_java17
    install_java21
    install_java23  # This will set Java 23 as default
}

install_clickup() {
    printf "\n${GREEN}Installing ClickUp...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "clickup" "clickup.AppImage"; then
        return 1
    fi

    # Installation
    mkdir -p /opt/clickup
    chmod +x clickup.AppImage
    mv clickup.AppImage /opt/clickup/
    
    # Copy icon (assuming icons directory exists in the same location as setup.sh)
    cp "$(dirname "$0")/icons/clickup.png" /opt/clickup/

    # Create desktop entry
    cat > /usr/share/applications/clickup.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=ClickUp
Icon=/opt/clickup/clickup.png
Exec=/opt/clickup/clickup.AppImage
Comment=ClickUp - Project Management Tool
Terminal=false
Categories=Office;ProjectManagement;
EOF

    # Cleanup
    printf "${GREEN}ClickUp installation completed!${RESET}\n"
    return 0
}

install_cursor() {
    printf "\n${GREEN}Installing Cursor...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "cursor" "cursor.AppImage"; then
        return 1
    fi

    # Installation
    mkdir -p /opt/cursor
    chmod +x cursor.AppImage
    mv cursor.AppImage /opt/cursor/
    
    # Copy icon (assuming icons directory exists in the same location as setup.sh)
    cp "$(dirname "$0")/icons/cursor.png" /opt/cursor/

    # Create desktop entry
    cat > /usr/share/applications/cursor.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Cursor
Icon=/opt/cursor/cursor.png
Exec=/opt/cursor/cursor.AppImage
Comment=Cursor - AI-first Code Editor
Terminal=false
Categories=Development;IDE;TextEditor;
EOF

    # Cleanup
    printf "${GREEN}Cursor installation completed!${RESET}\n"
    return 0
}

install_droidcam() {
    printf "\n${GREEN}Installing DroidCam...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "droidcam" "droidcam_latest.zip"; then
        return 1
    fi

    # Verify SHA1 checksum
    if ! echo "2646edd5ad2cfb046c9c695fa6d564d33be0f38b droidcam_latest.zip" | sha1sum -c; then
        printf "${RED}Checksum verification failed${RESET}\n"
        return 1
    fi

    # Extract and install
    unzip droidcam_latest.zip -d droidcam || return 1
    cd droidcam || return 1

    # Install client and video module
    ./install-client || {
        printf "${RED}Failed to install DroidCam client${RESET}\n"
        return 1
    }

    ./install-video || {
        printf "${RED}Failed to install video module${RESET}\n"
        return 1
    }

    # Cleanup
    cd /tmp
    rm -rf droidcam*

    printf "${GREEN}DroidCam installation completed!${RESET}\n"
    printf "${BLUE}Please restart your computer to complete the installation.${RESET}\n"
    return 0
}

install_zsh() {
    printf "\n${GREEN}Starting ZSH + Oh My ZSH + Powerlevel10k installation...${RESET}\n"
    
    # Get real user info
    REAL_USER=$(logname || who | awk '{print $1}' | head -n 1)
    if [ -z "$REAL_USER" ]; then
        printf "${RED}Could not determine the real user. Exiting...${RESET}\n"
        return 1
    }

    REAL_HOME=$(eval echo ~${REAL_USER})
    if [ ! -d "$REAL_HOME" ]; then
        printf "${RED}Home directory $REAL_HOME does not exist. Exiting...${RESET}\n"
        return 1
    }

    # Install ZSH
    printf "\n${BLUE}Installing ZSH...${RESET}\n"
    pacman -Sy --noconfirm zsh || {
        printf "${RED}Failed to install ZSH. Exiting...${RESET}\n"
        return 1
    }

    # Set ZSH as default shell
    printf "\n${BLUE}Setting ZSH as default shell...${RESET}\n"
    chsh -s /usr/bin/zsh $REAL_USER

    # Install Oh My ZSH
    printf "\n${BLUE}Installing Oh My ZSH...${RESET}\n"
    su -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended" - $REAL_USER

    # Install required fonts
    printf "\n${BLUE}Installing required fonts...${RESET}\n"
    pacman -S --noconfirm ttf-meslo-nerd-font-powerlevel10k || {
        printf "${RED}Failed to install fonts. Exiting...${RESET}\n"
        return 1
    }

    # Install Powerlevel10k theme
    printf "\n${BLUE}Installing Powerlevel10k theme...${RESET}\n"
    su - $REAL_USER -c "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${REAL_HOME}/.oh-my-zsh/custom/themes/powerlevel10k"

    # Install plugins
    printf "\n${BLUE}Installing ZSH plugins...${RESET}\n"
    su - $REAL_USER -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git ${REAL_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    su - $REAL_USER -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${REAL_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

    # Configure .zshrc
    printf "\n${BLUE}Configuring .zshrc...${RESET}\n"
    su - $REAL_USER -c "sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/' ${REAL_HOME}/.zshrc"
    su - $REAL_USER -c "sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ${REAL_HOME}/.zshrc"

    printf "${GREEN}ZSH installation completed!${RESET}\n"
    printf "${BLUE}Please log out and log back in to start using ZSH.${RESET}\n"
    printf "${BLUE}After logging back in, run 'p10k configure' to setup Powerlevel10k theme.${RESET}\n"
    
    return 0
}

install_zotero() {
    printf "\n${GREEN}Installing Zotero...${RESET}\n"
    cd /tmp || exit 1
    
    if ! download_from_web_programs "zotero" "zotero.tar.bz2"; then
        return 1
    fi

    # Installation
    tar -xjf zotero.tar.bz2 || return 1
    mv Zotero_linux-x86_64 /opt/zotero

    # Create desktop entry
    cat > /usr/share/applications/zotero.desktop << EOF
[Desktop Entry]
Name=Zotero
Exec=/opt/zotero/zotero
Icon=/opt/zotero/icons/icon128.png
Type=Application
Terminal=false
Categories=Office;
MimeType=text/plain;x-scheme-handler/zotero;application/x-research-info-systems;text/x-research-info-systems;text/ris;application/x-endnote-refer;application/x-inst-for-Scientific-info;application/mods+xml;application/rdf+xml;application/x-bibtex;text/x-bibtex;application/marc;application/vnd.citationstyles.style+xml
X-GNOME-SingleWindow=true
EOF

    # Cleanup
    rm -f zotero.tar.bz2
    printf "${GREEN}Zotero installation completed!${RESET}\n"
    return 0
}

########################
# Main Installation    #
########################
check_and_install_aur
install_base_system_packages
install_official_packages
install_aur_packages
install_snap_packages
install_flatpak_packages
install_all_java
install_intellij_idea
install_datagrip
install_goland
install_maven
install_gradle
install_springboot
install_clickup
install_cursor
install_droidcam
install_zsh
install_zotero