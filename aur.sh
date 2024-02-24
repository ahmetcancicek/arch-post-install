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


printf "\n${GREEN}"
cat <<EOL
===========================================================================
Congratulations, everything you wanted to install is installed!
===========================================================================
EOL
printf "${ENDCOLOR}\n"

cat <<EOL

EOL