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
JETBRAINS_VERSION=2023.3.4
GO_VERSION=1.22.0
POSTMAN_VERSION=10.23
MAVEN=3
MAVEN_VERSION=3.9.6
GRADLE_VERSION=8.2.1
SPRING_VERSION=3.2.2
ANKI_VERSION=23.12.1
DROIDCAM_VERSION=2.1.2

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


# Install Bluetooth Driver
print_installation_message Bluetooth
pacman -S --noconfirm bluez \
	bluez-utils \
	blueman
systemctl start bluetooth.service
systemctl enable bluetooth.service
print_installation_message_success Bluetooth

# Install Flatpak
print_installation_message Flatpak
# Install Flatpak Repository
pacman -S --noconfirm flatpak
print_installation_message_success Flatpak

# GNOME Extensions
print_installation_message Extensions
pacman -S --noconfirm gnome-shell-extensions
pacman -S --noconfirm gnome-browser-connector
pacman -S --noconfirm gnome-themes-extra
print_installation_message_success Extensions

# Install Firefox
print_installation_message Firefox
pacman -S --noconfirm firefox
print_installation_message_success Firefox

# Install Chromium
print_installation_message Chromium
pacman -S --noconfirm chromium
print_installation_message_success Chromium

# Install Spotify
print_installation_message Spotify
pacman -S --noconfirm spotify-launcher
print_installation_message_success Spotify

# Install Opera
print_installation_message Opera
pacman -S --noconfirm opera
print_installation_message_success Opera

# Install Zoom
print_installation_message Zoom
wget https://zoom.us/client/5.16.2.8828/zoom_x86_64.pkg.tar.xz
pacman -U --noconfirm zoom_x86_64.pkg.tar.xz
print_installation_message_success Zoom

# Install Discord
print_installation_message Discord
pacman -S --noconfirm discord
print_installation_message_success Discord

# Install Thunderbird
print_installation_message Thunderbird
pacman -S --noconfirm thunderbird
print_installation_message_success Thunderbird

# Install GIT
print_installation_message GIT
pacman -S --noconfirm  git
print_installation_message_success GIT

# Install Vim
print_installation_message Vim
pacman -S --noconfirm vim
print_installation_message_success Vim

# Install Gnome-Boxes
print_installation_message Boxes
pacman -S --noconfirm gnome-boxes
print_installation_message_success Boxes

# Install Terminator
print_installation_message Terminator
pacman -S --noconfirm terminator
print_installation_message_success Terminator

# Install GIMP
print_installation_message GIMP
pacman -S --noconfirm gimp
print_installation_message_success GIMP

# Install KeePassXC
print_installation_message KeePassXC
pacman -S --noconfirm keepassxc
print_installation_message_success KeePassXC

# Install Gnome Boxes
print_installation_message Boxes
pacman -S --noconfirm gnome-boxes
print_installation_message_success Boxes

# Install VirtualBox
print_installation_message VirtualBox
pacman -S --noconfirm virtualbox-host-modules-arch
pacman -S --noconfirm virtualbox
modprobe vboxdrv
print_installation_message_success VirtualBox

# Install LibreOffice
print_installation_message LibreOffice
pacman -S --noconfirm libreoffice
print_installation_message_success LibreOffice

# Install OpenVPN
print_installation_message OpenVPN
pacman -S --noconfirm openvpn
pacman -S --noconfirm networkmanager-openvpn
print_installation_message_success OpenVPN

print_installation_message libappindicator
pacman -S --noconfirm libappindicator-gtk3
print_installation_message_success libappindicator

# Gnome Sound Recorder
print_installation_message SoundRecorder
pacman -S --noconfirm gnome-sound-recorder
print_installation_message_success SoundRecorder

# Install Timeshift
print_installation_message Timeshift
pacman -S --noconfirm timeshift
print_installation_message_success Timeshift

# Install Gparted
print_installation_message Gparted
pacman -S --noconfirm gparted
print_installation_message_success Gparted

# Install Kdenlive
print_installation_message Kdenlive
pacman -S --noconfirm kdenlive
print_installation_message_success Kdenlive

# Install Krita
print_installation_message Krita
pacman -S --noconfirm krita
print_installation_message_success Krita

# Install Inkscape
print_installation_message Inkscape
pacman -S --noconfirm inkscape
print_installation_message_success Inkscape

# Install Raindrop
print_installation_message Raindrop
snap install raindrop
print_installation_message_success Raindrop

# Install Anki
print_installation_message Anki
pacman -S --noconfirm zstd
wget https://github.com/ankitects/anki/releases/download/23.12.1/anki-${ANKI_VERSION}-linux-qt6.tar.zst -O anki.tar.zst
# pacman -U --noconfirm anki.tar.zst
tar xaf anki.tar.zst
cd anki-${ANKI_VERSION}-linux-qt6
sudo ./install.sh
print_installation_message_success Anki

# Install JAVA
print_installation_message JAVA
pacman -S --noconfirm jdk-openjdk
archlinux-java status
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
tar xf jdk-21_linux-x64_bin.tar.gz -C /usr/lib/jvm
touch /etc/profile.d/jdk21.sh
echo -e '\n# JAVA Configuration' >> /etc/profile.d/jdk21.sh
echo 'JAVA_HOME=/usr/lib/jvm/jdk-20.0.2' >> /etc/profile.d/jdk21.sh
chmod +x /etc/profile.d/jdk21.sh
source /etc/profile.d/jdk21.sh
archlinux-java set jdk-21.0.1

wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
tar xf jdk-17_linux-x64_bin.tar.gz -C /usr/lib/jvm
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
print_installation_message_success SprintCLI

# Install Maven
print_installation_message Maven
wget https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-3.9.4-bin.tar.gz
tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
touch /etc/profile.d/maven.sh
echo -e '\n# Maven Configuration' >> /etc/profile.d/maven.sh
echo "export M2_HOME=/opt/maven" >> /etc/profile.d/maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
echo 'export JAVA_HOME=/usr/lib/jvm/jdk-20.0.2/' >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
print_installation_message_success Maven

# Install Gradle
print_installation_message Gradle
rm -rf gradle-${GRADLE_VERSION}-bin.zip
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip
ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
echo -e '\n# Gradle Configuration' >> /etc/profile.d/gradle.sh
echo -ne 'export PATH=$PATH:/opt/gradle/bin' >> /etc/profile.d/gradle.sh
chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
print_installation_message_success Gradle

# Install IntelliJ IDEA
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
print_installation_message_success IntelliJIDEA

# Install DataGrip
print_installation_message DataGrip
wget https://download.jetbrains.com/datagrip/datagrip-${JETBRAINS_VERSION}.tar.gz
tar -xzf datagrip-${JETBRAINS_VERSION}.tar.gz -C /opt
mv /opt/DataGrip-* /opt/DataGrip-${JETBRAINS_VERSION}
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
print_installation_message_success DataGrip

# Install Postman
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
print_installation_message_success Postman

# Install GoLang
print_installation_message GoLang
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
touch /etc/profile.d/go.sh
echo -e '\n# GoLang configuration ' >> /etc/profile.d/go.sh
echo 'export PATH="$PATH:/usr/local/go/bin"' >> /etc/profile.d/go.sh
echo 'export GOPATH="$HOME/go"' >> /etc/profile.d/go.sh
chmod +x /etc/profile.d/go.sh
source /etc/profile.d/go.sh
print_installation_message_success GoLang

# Install Docker
print_installation_message Docker
pacman -S --noconfirm docker
docker version
systemctl start docker.service
systemctl status docker.service
systemctl enable docker.service
usermod -aG docker $USER
pacman -S --noconfirm docker-compose
print_installation_message_success Docker

# Install Droidcam
print_installation_message Droidcam
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_2.1.1.zip
unzip droidcam_latest.zip -d droidcam
cd droidcam && ./install-client
cd ..
pacman -S --noconfirm android-tools v4l2loopback-dkms ffmpeg android-udev --needed
pacman -S --noconfirm linux-headers
print_installation_message_success Droidcam

# Install Nvidia Driver
# pacman -S nvidia \
# nvidia-settings

# Install ZSH & Oh My ZSH
print_installation_message ZSH
pacman -S --noconfirm zsh
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
pacman -S --noconfirm powerline-fonts
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
print_installation_message_success ZSH

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
