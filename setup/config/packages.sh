#!/bin/bash

# Base system packages
declare -A base_packages=(
    [core]="linux-headers linux-lts-headers base-devel"
    [utils]="htop tree wget usbutils ntfsprogs dosfstools dialog unzip net-tools openssh"
)

# Official Repository Packages
declare -A official_packages=(
    [internet]="firefox chromium"
    [multimedia]="vlc gimp kdenlive krita inkscape"
    [development]="git vim docker docker-compose nodejs npm python python-pip"
    [utilities]="keepassxc virtualbox terminator gparted timeshift neofetch"
    [communication]="thunderbird"
    [office]="libreoffice"
)

# AUR Packages
declare -A aur_packages=(
    [browsers]="google-chrome microsoft-edge-stable brave-bin"
    [development]="visual-studio-code-bin android-tools"
    [utilities]="dropbox pcloud-drive"
    [system]="snapd"
)

# Snap Packages
declare -A snap_packages=(
    [utilities]="raindrop"
)

# Flatpak Packages
declare -A flatpak_packages=(
    [multimedia]="com.obsproject.Studio"
)

# Custom Program Installations
declare -A custom_programs=(
    [development]="intellij datagrip vscode spring maven gradle go postman"
    [languages]="java"
    [internet]="tor"
    [communication]="zoom"
    [education]="anki"
    [utilities]="cursor clickup zotero droidcam"
    [desktop]="gnome"
    [system]="drivers fonts zsh"
) 