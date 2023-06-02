#!/bin/sh

pacman -Syu --noconfirm
pacman -S --noconfirm tree \
	curl \
	wget \

pacman -S vim
