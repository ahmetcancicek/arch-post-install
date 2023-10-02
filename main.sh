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
JETBRAINS_VERSION=2023.2
POSTMAN_VERSION=10.17
MAVEN=3
MAVEN_VERSION=3.9.4
GRADLE_VERSION=8.2.1
SPRING=3.0.0
SPRING_VERSION=3.1.2

# Get USER name
USER=$(logname)

# Get HOME folder path
HOME=/home/$USER

# Go TEMP folder
cd /tmp


pacman -Syu --noconfirm

# Install Essentials
pacman -S --noconfirm tree \
	curl \
	wget \
	tree

# Install Bluetooth Driver
pacman -S --noconfirm bluez \
	bluez-utils \
	blueman
systemctl start bluetooth.service
systemctl enable bluetooth.service

# GNOME Extensions
pacman -S --noconfirm gnome-shell-extensions
pacman -S --noconfirm gnome-browser-connector
pacman -S --noconfirm gnome-themes-extra

# Install Vim
pacman -S --noconfirm vim

# Install Gnome-Boxes
pacman -S --noconfirm gnome-boxes

# Install Terminator
pacman -S --noconfirm terminator

# Install GIMP
pacman -S --noconfirm gimp

# Install GIT
pacman -S --noconfirm  git

# Install Thunderbird
pacman -S --noconfirm thunderbird

# Install KeePassXC
pacman -S --noconfirm keepassxc

# Install Gnome Boxes
pacman -S --noconfirm gnome-boxes

# Install Spotify
pacman -S --noconfirm spotify-launcher

# Install LibreOffice
pacman -S --noconfirm libreoffice

# Install OpenVPN
pacman -S --noconfirm openvpn
pacman -S --noconfirm networkmanager-openvpn

#
pacman -S libappindicator-gtk3


# Gnome Sound Recorder
pacman -S gnome-sound-recorder

# Install AUR
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install Google Chrome
yay -S google-chrome

# Install Galaxy Buds Client
yay -S galaxybudsclient-bin

# Install VSCODE
yay -S visual-studio-code-bin

# Android Tools
yay -S android-tools

# Install JAVA
pacman -S --noconfirm jre-openjdk
archlinux-java status
wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.tar.gz
tar xf jdk-20_linux-x64_bin.tar.gz -C /usr/lib/jvm
touch /etc/profile.d/jdk20.sh
echo -e '\n# JAVA Configuration' >> /etc/profile.d/jdk20.sh
echo 'JAVA_HOME=/usr/lib/jvm/jdk-20.0.2' >> /etc/profile.d/jdk20.sh
chmod +x /etc/profile.d/jdk20.sh
source /etc/profile.d/jdk20.sh
archlinux-java set jdk-20.0.1

# Install Sprint CLI
wget https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
tar xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz -C /opt
echo -e "\n# Spring Boot CLI" >> /etc/profile.d/spring.sh
echo -ne 'export SPRING_HOME=/opt/spring-' >> /etc/profile.d/spring.sh
echo "${SPRING_VERSION}" >> /etc/profile.d/spring.sh
echo 'export PATH=$PATH:$HOME/bin:$SPRING_HOME/bin' >> /etc/profile.d/spring.sh
chmod +x /etc/profile.d/spring.sh
source /etc/profile.d/spring.sh

# Install Maven
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


# Install Gradle
rm -rf gradle-${GRADLE_VERSION}-bin.zip
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip
ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
echo -e '\n# Gradle Configuration' >> /etc/profile.d/gradle.sh
echo -ne 'export PATH=$PATH:/opt/gradle/bin' >> /etc/profile.d/gradle.sh
chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh


# Install IntelliJ IDEA
wget https://download.jetbrains.com/idea/ideaIU-${JETBRAINS_VERSION}.tar.gz -O ideaIU.tar.gz
tar -xzf ideaIU.tar.gz -C /opt
mv /opt/idea-IU-* /opt/idea-IU-${JETBRAINS_VERSION}
ln -s /opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.sh /usr/local/bin/idea
echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=IntelliJ IDEA Ultimate Edition
          Icon=/opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.svg
          Exec=/opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.sh %f
          Comment=Capable and Ergonomic IDE for JVM
          Categories=Development;IDE;
          Terminal=false
          StartupWMClass=jetbrains-idea
          StartupNotify=true;" >>/usr/share/applications/jetbrains-idea.desktop

# Install Postman
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


# Install Docker
pacman -S --noconfirm docker
docker version
systemctl start docker.service
systemctl status docker.service
systemctl enable docker.service
usermod -aG docker $USER
pacman -S --noconfirm docker-compose



# Install Flatpak Repository
pacman -S --noconfirm flatpak


# Install Nvidia Driver
pacman -S nvidia \
	nvidia-settings
