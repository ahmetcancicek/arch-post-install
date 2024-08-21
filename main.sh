#!/bin/sh

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"


# For root control
if [ "$(id -u)" != 0 ]; then
  printf "${RED}"
  cat <<EOL
========================================================================
You are not root! This script must be run as root!
========================================================================
EOL
  printf "${ENDCOLOR}"
  exit 1
fi

# Set Version
JETBRAINS_VERSION=2024.2.0.1
GO_VERSION=1.22.5
POSTMAN_VERSION=11.3.2
MAVEN=3
MAVEN_VERSION=3.9.8
GRADLE_VERSION=8.9
SPRING_VERSION=3.3.1
ANKI_VERSION=24.06.3
DROIDCAM_VERSION=2.1.3

# Get USER name
USER=$(logname)

# Get HOME folder path
HOME=/home/$USER

# Go TEMP folder
cd /tmp

# Update
printf "\n${BLUE}========================Installing Updating========================${ENDCOLOR}\n"
pacman -Syu --noconfirm
printf "${GREEN}========================Updated successfully!========================${ENDCOLOR}\n"


# Install Essentials
declare -A essential
essentials=(
  tree
	curl
	wget
	htop
  usbutils
  base-devel
  ntfsprogs
  dosfstools
  dialog
  unzip
)

printf "\n${BLUE}========================Installing standard package $1========================${ENDCOLOR}\n"
for key in "${essentials[@]}"; do
  pacman -S --noconfirm $key
done
printf "\n${BLUE}===============Standard packages are installed successfully=============== ${ENDCOLOR}\n"


# Go /tmp
go_temp() {
  cd /tmp
}


# Installation Message
print_installation_message() {
  printf "\n${BLUE}===============================Installing $1==============================${ENDCOLOR}\n"
}

# Installation Success Message
print_installation_message_success() {
  printf "${GREEN}========================$1 is installed successfully!========================${ENDCOLOR}\n"
  go_temp
}

# Install AUR
sudo -u $USER bash -c '\
cd $HOME
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd /tmp
'

# Install Bluetooth Driver
install_bluetooth(){
  print_installation_message Bluetooth
  pacman -S --noconfirm bluez \
  	bluez-utils \
  	blueman
  systemctl start bluetooth.service
  systemctl enable bluetooth.service
  print_installation_message_success Bluetooth
}

# Flatpak Repository
install_flatpak() {
  # Install Flatpak
  print_installation_message Flatpak
  # Install Flatpak Repository
  pacman -S --noconfirm flatpak
  print_installation_message_success Flatpak
}

# Gnome
install_gnome_tool() {
  # GNOME Extensions
  print_installation_message Extensions
  pacman -S --noconfirm gnome-shell-extensions
  pacman -S --noconfirm gnome-browser-connector
  pacman -S --noconfirm gnome-themes-extra

  # Monitor scaling
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer','kms-modifiers']"

  print_installation_message_success Extensions
}

# Firefox
install_firefox(){
  # Install Firefox
  print_installation_message Firefox
  pacman -S --noconfirm firefox
  print_installation_message_success Firefox
}

# Chromium
install_chromium() {
  # Install Chromium
  print_installation_message Chromium
  pacman -S --noconfirm chromium
  print_installation_message_success Chromium
}

# Spotify
install_spotify() {
  print_installation_message Spotify
  pacman -S --noconfirm spotify-launcher
  print_installation_message_success Spotify
}

# Zoom
install_zoom() {
  print_installation_message Zoom
  wget https://zoom.us/client/5.16.2.8828/zoom_x86_64.pkg.tar.xz
  pacman -U --noconfirm zoom_x86_64.pkg.tar.xz
  print_installation_message_success Zoom
}

# Discord
install_discord() {
  print_installation_message Discord
  pacman -S --noconfirm discord
  print_installation_message_success Discord
}

# Thunderbird
install_thunderbird() {
  print_installation_message Thunderbird
  pacman -S --noconfirm thunderbird
  print_installation_message_success Thunderbird
}

# GIT
install_git() {
  print_installation_message GIT
  pacman -S --noconfirm  git
  print_installation_message_success GIT
}

# Vim
install_vim() {
  print_installation_message Vim
  pacman -S --noconfirm vim
  print_installation_message_success Vim
}

# Gnome-Boxes
install_gnome_boxes() {
  print_installation_message Boxes
  pacman -S --noconfirm gnome-boxes
  print_installation_message_success Boxes
}

# Terminator
install_terminator() {
  print_installation_message Terminator
  pacman -S --noconfirm terminator
  print_installation_message_success Terminator
}

# Gimp
install_gimp() {
  print_installation_message GIMP
  pacman -S --noconfirm gimp
  print_installation_message_success GIMP
}

# KeePassXC
install_keepassxc() {
  print_installation_message KeePassXC
  pacman -S --noconfirm keepassxc
  print_installation_message_success KeePassXC
}

# VirtualBox
install_virtualbox() {
  print_installation_message VirtualBox
  pacman -S --noconfirm virtualbox-host-modules-arch
  pacman -S --noconfirm virtualbox
  modprobe vboxdrv
  print_installation_message_success VirtualBox
}

# LibreOffice
install_libreoffice(){
  print_installation_message LibreOffice
  pacman -S --noconfirm libreoffice
  print_installation_message_success LibreOffice
}

# OpenVPN
install_openvpn() {
  print_installation_message OpenVPN
  pacman -S --noconfirm openvpn
  pacman -S --noconfirm networkmanager-openvpn
  print_installation_message_success OpenVPN
}

install_libappindicator(){
  print_installation_message libappindicator
  pacman -S --noconfirm libappindicator-gtk3
  print_installation_message_success libappindicator
}

# Gnome Sound Recorder
install_soundrecorder(){
  print_installation_message SoundRecorder
  pacman -S --noconfirm gnome-sound-recorder
  print_installation_message_success SoundRecorder
}

# Timeshift
install_timeshift(){
  print_installation_message Timeshift
  pacman -S --noconfirm timeshift
  print_installation_message_success Timeshift
}

# Gparted
install_gparted(){
  print_installation_message Gparted
  pacman -S --noconfirm gparted
  print_installation_message_success Gparted
}

# Kdenlive
install_kdenlive(){
  print_installation_message Kdenlive
  pacman -S --noconfirm kdenlive
  print_installation_message_success Kdenlive
}

# Krita
install_krita(){
  print_installation_message Krita
  pacman -S --noconfirm krita
  print_installation_message_success Krita
}

# Inkscape
install_inkscape(){
  print_installation_message Inkscape
  pacman -S --noconfirm inkscape
  print_installation_message_success Inkscape
}

# Anki
install_anki(){
  print_installation_message Anki
  pacman -S --noconfirm zstd
  wget https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst -O anki.tar.zst
  # pacman -U --noconfirm anki.tar.zst
  tar xaf anki.tar.zst
  cd anki-${ANKI_VERSION}-linux-qt6
  sudo ./install.sh
  print_installation_message_success Anki
}

# OpenJDK
install_openJDK(){
  print_installation_message JAVA
  pacman -S --noconfirm jdk-openjdk
  archlinux-java status
  print_installation_message_success JAVA
}

# ORACLE JAVA JDK 18 &  ORACLE JAVA JDK 21 & ORACLE JAVA JDK 17 && SPRING BOOT CLI
install_javaJDK() {
  print_installation_message JAVA
  wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
  tar xf jdk-21_linux-x64_bin.tar.gz
  mv jdk-21.* jdk-21
  mv jdk-21 /usr/lib/jvm
  touch /etc/profile.d/jdk21.sh
  echo -e '\n# JAVA Configuration' >> /etc/profile.d/jdk21.sh
  echo 'JAVA_HOME=/usr/lib/jvm/jdk-21' >> /etc/profile.d/jdk21.sh
  chmod +x /etc/profile.d/jdk21.sh
  source /etc/profile.d/jdk21.sh
  archlinux-java set jdk-21

  wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
  tar xf jdk-17_linux-x64_bin.tar.gz -C /usr/lib/jvm

  rm -rf /tmp/jdk-21_linux-x64_bin.tar.gz
  rm -rf /tmp/jdk-17_linux-x64_bin.tar.gz
  print_installation_message_success JAVA

  # Install Sprint CLI
  print_installation_message SprintCLI
  wget https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
  tar xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz -C /opt
  echo -e "\n# Spring Boot CLI" >> /etc/profile.d/spring.sh
  echo -ne 'export SPRING_HOME=/opt/spring-' >> /etc/profile.d/spring.sh
  echo "${SPRING_VERSION}" >> /etc/profile.d/spring.sh
  echo 'export PATH=$PATH:$HOME/bin:$SPRING_HOME/bin' >> /etc/profile.d/spring.sh
  chmod +x /etc/profile.d/spring.sh
  source /etc/profile.d/spring.sh

  rm -rf /tmp/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
  print_installation_message_success SprintCLI
}

# Maven
install_maven() {
  print_installation_message Maven
  wget https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
  tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
  ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
  touch /etc/profile.d/maven.sh
  echo -e '\n# Maven Configuration' >> /etc/profile.d/maven.sh
  echo "export M2_HOME=/opt/maven" >> /etc/profile.d/maven.sh
  echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
  echo 'export JAVA_HOME=/usr/lib/jvm/jdk-21/' >> /etc/profile.d/maven.sh
  chmod +x /etc/profile.d/maven.sh
  source /etc/profile.d/maven.sh
  rm -rf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz
  print_installation_message_success Maven
}

# Gradle
  install_gradle() {
  print_installation_message Gradle
  rm -rf gradle-${GRADLE_VERSION}-bin.zip
  wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
  unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip
  ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
  echo -e '\n# Gradle Configuration' >> /etc/profile.d/gradle.sh
  echo -ne 'export PATH=$PATH:/opt/gradle/bin' >> /etc/profile.d/gradle.sh
  chmod +x /etc/profile.d/gradle.sh
  source /etc/profile.d/gradle.sh
  rm -rf /tmp/gradle-${GRADLE_VERSION}-bin.zip
  print_installation_message_success Gradle
}

# Intellij-IDEA
install_intellij_idea() {
  print_installation_message IntelliJIDEA
  wget https://download.jetbrains.com/idea/ideaIU-${JETBRAINS_VERSION}.tar.gz -O ideaIU.tar.gz
  tar -xf ideaIU.tar.gz -C /opt
  mv /opt/idea-IU-* /opt/idea-IU-${JETBRAINS_VERSION}
  ln -s /opt/idea-IU-${JETBRAINS_VERSION} /opt/idea
  ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea
  echo "[Desktop Entry]
        Version=1.0
        Type=Application
        Name=IntelliJ IDEA Ultimate Edition
        Icon=/opt/idea/bin/idea.svg
        Exec=/opt/idea/bin/idea.sh %f
        Comment=Capable and Ergonomic IDE for JVM
        Categories=Development;IDE;
        Terminal=false
        StartupWMClass=jetbrains-idea
        StartupNotify=true;" >>/usr/share/applications/jetbrains-idea.desktop
  rm -rf /tmp/ideaIU.tar.gz
  print_installation_message_success IntelliJIDEA
}

# DataGrip
install_datagrip() {
  print_installation_message DataGrip
  wget https://download.jetbrains.com/datagrip/datagrip-${JETBRAINS_VERSION}.tar.gz
  tar -xzf datagrip-${JETBRAINS_VERSION}.tar.gz -C /opt
  ln -s /opt/DataGrip-${JETBRAINS_VERSION} /opt/datagrip
  ln -s /opt/datagrip/bin/datagrip.sh /usr/local/bin/datagrip
  echo "[Desktop Entry]
        Version=1.0
        Type=Application
        Name=DataGrip
        Icon=/opt/datagrip/bin/datagrip.png
        Exec=/opt/datagrip/bin/datagrip.sh
        Terminal=false
        Categories=Development;IDE;" >>/usr/share/applications/jetbrains-datagrip.desktop
  rm -rf /tmp/datagrip-${JETBRAINS_VERSION}.tar.gz
  print_installation_message_success DataGrip
}

# GoLand
install_goland() {
  print_installation_message GoLand
  wget https://download.jetbrains.com/go/goland-${JETBRAINS_VERSION}.tar.gz -O goland.tar.gz
  tar -xzf goland.tar.gz -C /opt
  mv /opt/GoLand-* /opt/GoLand-${JETBRAINS_VERSION}
  ln -s /opt/GoLand-${JETBRAINS_VERSION} /opt/goland
  ln -s /opt/goland/bin/goland.sh /usr/local/bin/goland
  echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=GoLand
          Icon=/opt/GoLand-${JETBRAINS_VERSION}/bin/goland.png
          Exec=/opt/GoLand-${JETBRAINS_VERSION}/bin/goland.sh
          Terminal=false
          Categories=Development;IDE;" >>/usr/share/applications/jetbrains-goland.desktop
  rm -rf /tmp/goland.tar.gz
  print_installation_message_success GoLand
}

# Postman
install_postman() {
  print_installation_message Postman
  curl https://dl.pstmn.io/download/latest/linux64 --output postman-${POSTMAN_VERSION}-linux-x64.tar.gz
  tar -xzf postman-${POSTMAN_VERSION}-linux-x64.tar.gz -C /opt
  echo "[Desktop Entry]
        Encoding=UTF-8
        Name=Postman
        Exec=/opt/Postman/app/Postman %U
        Icon=/opt/Postman/app/resources/app/assets/icon.png
        Terminal=false
        Type=Application
        Categories=Development;" >>/usr/share/applications/Postman.desktop
  rm -rf /tmp/postman-${POSTMAN_VERSION}-linux-x64.tar.gz
  print_installation_message_success Postman
}

# Install GoLang
install_go() {
  print_installation_message GoLang
  wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
  rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
  touch /etc/profile.d/go.sh
  echo -e '\n# GoLang configuration ' >> /etc/profile.d/go.sh
  echo 'export PATH="$PATH:/usr/local/go/bin"' >> /etc/profile.d/go.sh
  echo 'export GOPATH="$HOME/go"' >> /etc/profile.d/go.sh
  chmod +x /etc/profile.d/go.sh
  source /etc/profile.d/go.sh
  rm -rf /tmp/go${GO_VERSION}.linux-amd64.tar.gz
  print_installation_message_success GoLang
}

# Docker
install_docker() {
  print_installation_message Docker
  pacman -S --noconfirm docker
  docker version
  systemctl start docker.service
  systemctl status docker.service
  systemctl enable docker.service
  usermod -aG docker $USER
  pacman -S --noconfirm docker-compose
  print_installation_message_success Docker
}

# Snap Repository
install_snap() {
  print_installation_message Snap
  sudo -u $USER bash -c '\
  yes | yay -S snapd  '
  systemctl enable --now snapd.socket
  ln -s /var/lib/snapd/snap /snap
  systemctl start snapd.service
  systemctl enable snapd.service
  print_installation_message_success Snap
}

# Google Chrome
install_google_chrome() {
  print_installation_message Chrome
  sudo -u $USER bash -c '\
  yes |  yay -S google-chrome  '
  # yay -S google-chrome --answerdiff=None
  print_installation_message_success Chrome
}

# Microsoft Edge
install_microsoft_edge() {
  print_installation_message Edge
  sudo -u $USER bash -c '\
  yes |  yay -S microsoft-edge-stable  '
  print_installation_message_success Edge
}

# Brave
install_brave(){
  print_installation_message Brave
  sudo -u $USER bash -c '\
  yes | yay -S brave-bin  '
  print_installation_message_success Brave
}

# VSCODE
install_vscode() {
print_installation_message VSCODE
  sudo -u $USER bash -c '\
  yes | yay -S visual-studio-code-bin  '
print_installation_message_success VSCODE
}

# Android Tools
install_android(){
  print_installation_message AndroidTools
  sudo -u $USER bash -c '\
  yes | yay -S android-tools  '
  print_installation_message_success AndroidTools
}


# Web-Apps
install_web_apps() {
  print_installation_message WebApps
  sudo -u $USER bash -c '\
  yes | yay -S webapp-manager  '
  print_installation_message_success WebApps
}

# Dropbox
install_dropbox() {
  print_installation_message Dropbox
  sudo -u $USER bash -c '\
  yes | yay -S dropbox  '
  print_installation_message_success Dropbox
}

# pCloud
install_pcloud(){
  print_installation_message pCloud
  sudo -u $USER bash -c '\
  yes | yay -S pcloud-drive  '
  print_installation_message_success pCloud
}

# Galaxy Buds Client
install_galaxybudsclient(){
  print_installation_message galaxybudsclient
  sudo -u $USER bash -c '\
  yes | yay -S galaxybudsclient-bin  '
  print_installation_message_success galaxybudsclient
}

# Raindrop
install_raindrop(){
  print_installation_message Raindrop
  sudo -u $USER bash -c '\
  snap install raindrop  '
  print_installation_message_success Raindrop
}

install_npm(){
  print_installation_message NPM
  pacman -S --noconfirm nodejs npm
  print_installation_message_success NPM
}

install_vlc(){
  print_installation_message VLC
  pacman -S --noconfirm vlc
  print_installation_message_success VLC
}

# Droidcam
install_droidcam() {
  print_installation_message Droidcam
  wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_2.1.1.zip
  unzip droidcam_latest.zip -d droidcam
  cd droidcam && ./install-client
  cd ..
  pacman -S --noconfirm android-tools v4l2loopback-dkms ffmpeg android-udev --needed
  # TODO: Fix the Kernel Problem
  # pacman -S --noconfirm linux-headers
  print_installation_message_success Droidcam
}


cmd=(dialog --title "Debian 12 Installer" --separate-output --checklist 'Please choose: ' 27 76 16)
options=(
  # A: Software Repositories
  A1 "Install Snap Repository" off
  A2 "Install Flatpak Repository" off
  # B: Internet
  B1 "Firefox" off
  B2 "Google Chrome" off
  B3 "Chromium" off
  B4 "Spotify" off
  B5 "Microsoft Edge" off
  B6 "Brave" off
  # C: Chat Application
  C1 "Zoom Meeting Client" off
  C2 "Discord" off
  C3 "Thunderbird Mail" off
  # D: Development
  D1 "GIT" off
  D2 "JAVA" off
  D3 "GO" off
  D4 "Microsoft Visual Studio Code" off
  D5 "IntelliJ IDEA Ultimate" off
  D6 "GoLand" off
  D7 "Postman" off
  D8 "Docker" off
  D9 "Maven" off
  D10 "Gradle" off
  D11 "Node.js & NPM" off
  D12 "Vim" off
  D13 "DataGrip" off
  D14 "Android Tools" off
  # E: Environment
  E1 "Gnome Tweak Tool & Extensions" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Virtualbox" off
  F4 "Gnome Boxes" off
  F5 "Terminator" off
  F6 "Web Apps" off
  F7 "OpenVPN" off
  F8 "Timeshift" off
  F9 "Gparted" off
  F10 "pCloud" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Kdenlive" off
  G3 "Krita" off
  G4 "Inkscape" off
  G5 "Gnome Sound Recorder" off
  G6 "VLC" off
  # H: Productivity
  H1 "LibreOffice" off
  H2 "Anki" off
)


choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices; do
  case $choice in
  A1)
    install_snap
    ;;
  A2)
    install_flatpak
    ;;

  B1)
    install_firefox
    ;;
  B2)
    install_google_chrome
    ;;
  B3)
    install_chromium
    ;;
  B4)
    install_spotify
    ;;
  B5)
    install_microsoft_edge
    ;;
  B6)
    install_brave
    ;;

  C1)
    install_zoom
    ;;
  C2)
    install_discord
    ;;
  C3)
    install_thunderbird
    ;;

  D1)
    install_git
    ;;
  D2)
    install_openJDK
    install_javaJDK
    ;;
  D3)
    install_go
    ;;
  D4)
    install_vscode
    ;;
  D5)
    install_intellij_idea
    ;;
  D6)
    install_goland
    ;;
  D7)
    install_postman
    ;;
  D8)
    install_docker
    ;;
  D9)
    install_maven
    ;;
  D10)
    install_gradle
    ;;
  D11)
    install_npm
    ;;
  D12)
    install_vim
    ;;
  D13)
    install_datagrip
    ;;
  D14)
    install_android
    ;;

  E1)
    install_gnome_tool
    install_libappindicator
    ;;

  F1)
    install_dropbox
    ;;
  F2)
    install_keepassxc
    ;;
  F3)
    install_virtualbox
    ;;
  F4)
    install_gnome_boxes
    ;;
  F5)
    install_terminator
    ;;
  F6)
    install_web_apps
    ;;
  F7)
    install_openvpn
    ;;
  F8)
    install_timeshift
    ;;
  F9)
    install_gparted
    ;;
  F10)
    install_pcloud
    ;;

  G1)
    install_gimp
    ;;
  G2)
    install_kdenlive
    ;;
  G3)
    install_krita
    ;;
  G4)
    install_inkscape
    ;;
  G5)
    install_soundrecorder
    ;;
  G6)
    install_vlc
    ;;

  H1)
    install_libreoffice
    ;;
  H2)
    install_anki
    ;;
  *)
  esac
done


printf "\n${GREEN}"
cat <<EOL
===========================================================================
Congratulations, everything you wanted to install is installed!
===========================================================================
EOL
printf "${ENDCOLOR}\n"

cat <<EOL

EOL

printf ${RED}
read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi
printf ${ENDCOLOR}

cat <<EOL

EOL