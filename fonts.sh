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


printf "${BLUE}"
cat <<EOL
========================================================================
Fonts is installing!
========================================================================
EOL
printf "${ENDCOLOR}"

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
  cd /usr/local/share/fonts/
  fc-cache -vf
  printf "${GREEN}========================$1 is installed successfully!========================${ENDCOLOR}\n"
  go_temp
}


cd /usr/local/share
mkdir fonts
cd /tmp

# Install Powerline Fonts
print_installation_message Powerline-Fonts
pacman -S --noconfirm powerline-fonts
print_installation_message_success Powerline-Fonts

# Roboto
print_installation_message Roboto
curl -o roboto.zip https://fonts.google.com/download?family=Roboto
unzip roboto.zip -d roboto
rm -rf /usr/local/share/fonts/roboto
mv roboto /usr/local/share/fonts/
print_installation_message_success Roboto

# Noto Sans
print_installation_message Noto-Sans
curl -o noto-sans.zip https://fonts.google.com/download?family=Noto%20Sans
unzip noto-sans.zip -d noto-sans
rm -rf /usr/local/share/fonts/noto-sans
mv noto-sans /usr/local/share/fonts/
print_installation_message_success Noto-Sans

# Fira Mono
print_installation_message Fira-Mono
curl -o fira-mono.zip https://fonts.google.com/download?family=Fira%20Mono
unzip fira-mono.zip -d fira-mono
rm -rf /usr/local/share/fonts/fira-mono
mv fira-mono /usr/local/share/fonts/
print_installation_message_success Fira-Mono

# Clear Sans
print_installation_message Clear-Sans
curl -o clear-sans.zip https://www.fontsquirrel.com/fonts/download/clear-sans
unzip clear-sans.zip -d clear-sans
rm -rf /usr/local/share/fonts/clear-sans
mv clear-sans /usr/local/share/fonts/
print_installation_message_success Clear-Sans

# Fira Sans Fira-Sans
print_installation_message Fira-Sans
curl -o fira-sans.zip https://fonts.google.com/download?family=Fira%20Sans
unzip fira-sans.zip -d fira-sans
rm -rf /usr/local/share/fonts/fira_sans
mv fira-sans /usr/local/share/fonts/
print_installation_message_success Fira-Sans

# Roboto Slab
print_installation_message Roboto-Slab
curl -o roboto-slab.zip https://fonts.google.com/download?family=Roboto%20Slab
unzip roboto-slab.zip -d roboto-slab
rm -rf /usr/local/share/fonts/roboto-slab
mv roboto-slab /usr/local/share/fonts/
print_installation_message_success Roboto-Slab

# Overpass
print_installation_message Overpass
curl -o overpass.zip https://fonts.google.com/download?family=Overpass
unzip overpass.zip -d overpass
rm -rf /usr/local/share/fonts/overpass
mv overpass /usr/local/share/fonts/
print_installation_message_success Overpass

# Ubuntu
print_installation_message Ubuntu
curl -o ubuntu.zip https://fonts.google.com/download?family=Ubuntu
unzip ubuntu.zip -d ubuntu
rm -rf /usr/local/share/fonts/ubuntu
mv ubuntu /usr/local/share/fonts/
print_installation_message_success Ubuntu

# Ubuntu Mono
print_installation_message Ubuntu-Mono
curl -o ubuntu-mono.zip https://fonts.google.com/download?family=Ubuntu%20Mono
unzip ubuntu-mono.zip -d ubuntu-mono
rm -rf /usr/local/share/fonts/ubuntu-mono
mv ubuntu-mono /usr/local/share/fonts/
print_installation_message_success Ubuntu-Mono

# Ubuntu Condensed
print_installation_message Ubuntu-Condensed
curl -o ubuntu-condensed.zip https://fonts.google.com/download?family=Ubuntu%20Condensed
unzip ubuntu-condensed.zip -d ubuntu-condensed
rm -rf /usr/local/share/fonts/ubuntu-condensed
mv ubuntu-condensed /usr/local/share/fonts/
print_installation_message_success Ubuntu-Condensed

# Overpass Mono
print_installation_message Overpass-Mono
curl -o overpass-mono.zip https://fonts.google.com/download?family=Overpass%20Mono
unzip overpass-mono.zip -d overpass-mono
rm -rf /usr/local/share/fonts/overpass-mono
mv overpass-mono /usr/local/share/fonts/
print_installation_message_success Overpass-Mono

# JetBrains Mono Font Family
print_installation_message JetBrains-Mono
rm -rf /usr/local/share/fonts/jetbrains-mono
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242 -d JetBrainsMono-2.242
mkdir jetbrains-mono
mv JetBrainsMono-2.242/fonts/ttf/** jetbrains-mono
mv jetbrains-mono /usr/local/share/fonts-
print_installation_message_success JetBrains-Mono

# Inter
print_installation_message Inter
rm -rf /usr/local/share/fonts/Inter-3.19
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
unzip Inter-3.19.zip -d Inter-3.19
rm -rf /usr/local/share/fonts/inter-3.19
mv Inter-3.19 /usr/local/share/fonts/
print_installation_message_success Inter

# Hack v3
print_installation_message Hack
rm -rf /usr/local/share/fonts/hack
wget -O hack-v3.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip hack-v3.zip -d hack-v3
mkdir hack
mv hack-v3/ttf/* hack
mv hack /usr/local/share/fonts/hack
print_installation_message_success Hack

# Install Monaco
print_installation_message Monaco
rm -rf /usr/local/share/fonts/monaco
mkdir /usr/local/share/fonts/monaco
cd /usr/local/share/fonts/monaco
wget http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf
print_installation_message_success Monaco

# Install MesloLGS
print_installation_message MesloLGS
rm -rf /usr/local/share/fonts/MesloLGS
mkdir /usr/local/share/fonts/MesloLGS
cd /usr/local/share/fonts/MesloLGS
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
print_installation_message_success MesloLGS


printf "${GREEN}"
cat <<EOL
===============================================================
Congratulations, everything you wanted to install is installed!
===============================================================
EOL
printf "${ENDCOLOR}"

cat <<EOL

EOL
