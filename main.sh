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



# Install Bluetooth Driver
pacman -S --noconfirm bluez \
	bluez-utils \
	blueman
systemctl start bluetooth.service
systemctl enable bluetooth.service

# Install AUR
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Insall Snap
yay -S snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
systemctl start snapd.service

# Install Flatpak Repository
pacman -S --noconfirm flatpak

# GNOME Extensions
pacman -S --noconfirm gnome-shell-extensions
pacman -S --noconfirm gnome-browser-connector
pacman -S --noconfirm gnome-themes-extra

# Install Chromium
pacman -S --noconfirm firefox

# Install Google Chrome
yay -S google-chrome

# Install Chromium
pacman -S --noconfirm chromium

# Install Spotify
pacman -S --noconfirm spotify-launcher

# Install Opera
pacman -S --noconfirm opera

# Install Microsoft Edge
yay -S microsoft-edge-stable

# Install Brave
yay -S brave-bin

# Install Zoom
wget https://zoom.us/client/5.16.2.8828/zoom_x86_64.pkg.tar.xz
pacman -U --noconfirm zoom_x86_64.pkg.tar.xz

# Install Discord
pacman -S discord

# Install Thunderbird
pacman -S --noconfirm thunderbird

# Install GIT
pacman -S --noconfirm  git

# Install Vim
pacman -S --noconfirm vim

# Install Gnome-Boxes
pacman -S --noconfirm gnome-boxes

# Install Terminator
pacman -S --noconfirm terminator

# Install Web Apps
yay -S webapp-manager

# Install GIMP
pacman -S --noconfirm gimp

# Install Dropbox
yay -S dropbox

# Install pCloud
yay -S pcloud-drive

# Install KeePassXC
pacman -S --noconfirm keepassxc

# Install Gnome Boxes
pacman -S --noconfirm gnome-boxes

# Install VirtualBox
pacman -S --noconfirm virtualbox-host-modules-arch
pacman -S virtualbox
modprobe vboxdrv

# Install LibreOffice
pacman -S --noconfirm libreoffice

# Install OpenVPN
pacman -S --noconfirm openvpn
pacman -S --noconfirm networkmanager-openvpn

pacman -S libappindicator-gtk3

# Gnome Sound Recorder
pacman -S gnome-sound-recorder

# Install Galaxy Buds Client
yay -S galaxybudsclient-bin

# Install VSCODE
yay -S visual-studio-code-bin

# Android Tools
yay -S android-tools

# Install Timeshift
pacman -S --noconfirm timeshift

# Install Gparted
pacman -S --noconfirm gparted

# Install Kdenlive
pacman -S --noconfirm kdenlive

# Install Krita
pacman -S --noconfirm krita

# Install Inkscape
pacman -S --noconfirm inkscape

# Install Raindrop
snap install raindrop

# Install Anki
pacman -S --noconfirm zstd
wget https://github.com/ankitects/anki/releases/download/23.12.1/anki-${ANKI_VERSION}-linux-qt6.tar.zst -O anki.tar.zst
tar xaf anki.tar.zst
cd anki-${ANKI_VERSION}-linux-qt6
sudo ./install.sh

# Install JAVA
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

# Install DataGrip
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

# Install GoLang
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
touch /etc/profile.d/go.sh
echo -e '\n# GoLang configuration ' >> /etc/profile.d/go.sh
echo 'export PATH="$PATH:/usr/local/go/bin"' >> /etc/profile.d/go.sh
echo 'export GOPATH="$HOME/go"' >> /etc/profile.d/go.sh
chmod +x /etc/profile.d/go.sh
source /etc/profile.d/go.sh

# Install Docker
pacman -S --noconfirm docker
docker version
systemctl start docker.service
systemctl status docker.service
systemctl enable docker.service
usermod -aG docker $USER
pacman -S --noconfirm docker-compose

# Install Droidcam
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_2.1.1.zip
unzip droidcam_latest.zip -d droidcam
cd droidcam && ./install-client
cd ..
pacman -S --noconfirm android-tools v4l2loopback-dkms ffmpeg android-udev --needed
pacman -S --noconfirm linux-headers

# Install Nvidia Driver
# pacman -S nvidia \
# nvidia-settings

# Install ZSH & Oh My ZSH
pacman -S --noconfirm zsh
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
pacman -S --noconfirm powerline-fonts
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting