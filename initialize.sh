#!/bin/sh

pacman -Syu --noconfirm


# Bluetooth
systemctl start bluetooth
systemctl enable bluetooth


# yay
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg si


# GNOME Extensions and Browser Connector
pacman -S gnome-shell-extensions
pacman -S gnome-browser-connector


pacman -S --noconfirm tree \
	curl \
	wget \
	tree \


pacman -S --noconfirm vim


pacman -S --noconfirm gnome-boxes

pacman -S --noconfirm terminator


yay -S visual-studio-code-bin

pacman -S git

pacman -S zsh

pacman -S spotify-launcher


yay -S google-chrome
yay -S keepassxc
