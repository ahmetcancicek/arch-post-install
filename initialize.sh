#!/bin/sh

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

# Install GIT
pacman -S --noconfirm  git

# Install Thunderbird
pacman -S --noconfirm thunderbird

# Install KeePassXC
pacman -S --noconfirm keepassxc

# Install Spotify
pacman -S --noconfirm spotify-launcher


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


# Install Maven
wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
tar xzf apache-maven-3.9.4-bin.tar.gz -C /opt
ln -s /opt/apache-maven-3.9.4 /opt/maven
touch /etc/profile.d/maven.sh
echo -e '\n# Maven Configuration' >> /etc/profile.d/maven.sh
echo "export M2_HOME=/opt/maven" >> /etc/profile.d/maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
echo 'export JAVA_HOME=/usr/lib/jvm/jdk-20.0.2/' >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

# Install Snap Repository
pacman -S snapd


# Install Flatpak Repository
#


# Install Nvidia Driver
pacman -S nvidia \
	nvidia-settings
