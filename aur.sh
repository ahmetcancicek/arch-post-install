#!/bin/sh

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"


# For root control
if [ "$(id -u)" == 1 ]; then
  printf "${RED}"
  cat <<EOL
========================================================================
You are root! This script must not be run as root!
========================================================================
EOL
  printf "${ENDCOLOR}"
  exit 1
fi

# Get USER name
USER=$(logname)

# Get HOME folder path
HOME=/home/$USER

# Go TEMP folder
cd /tmp

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


print_installation_message AUR
cd $HOME
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
print_installation_message_success AUR

# Insall Snap
print_installation_message Snap
yes | yay -S snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
systemctl start snapd.service
print_installation_message_success Snap

# Install Google Chrome
print_installation_message Chrome
yes |  yay -S google-chrome
# yay -S google-chrome --answerdiff=None
print_installation_message_success Chrome

# Install Microsoft Edge
print_installation_message Edge
yes | yay -S microsoft-edge-stable
print_installation_message_success Edge

# Install Brave
print_installation_message Brave
yes | yay -S brave-bin
print_installation_message_success Brave

# Install Web Apps
print_installation_message WebApps
yes | yay -S webapp-manager
print_installation_message_success WebApps

# Install Dropbox
print_installation_message Dropbox
yes | yay -S dropbox
print_installation_message_success Dropbox

# Install pCloud
print_installation_message pCloud
yes | yay -S pcloud-drive
print_installation_message_success pCloud

# Install Galaxy Buds Client
print_installation_message galaxybudsclient
yes | yay -S galaxybudsclient-bin
print_installation_message_success galaxybudsclient

# Install VSCODE
print_installation_message VSCODE
yes | yay -S visual-studio-code-bin
print_installation_message_success VSCODE

# Android Tools
print_installation_message AndroidTools
yes | yay -S android-tools
print_installation_message_success AndroidTools

printf "\n${GREEN}"
cat <<EOL
===========================================================================
Congratulations, everything you wanted to install is installed!
===========================================================================
EOL
printf "${ENDCOLOR}\n"

cat <<EOL

EOL