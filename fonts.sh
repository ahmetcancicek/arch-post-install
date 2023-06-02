#!/bin/sh

GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"



printf "${BLUE}"
cat <<EOL
========================================================
Fonts is installing!
========================================================
EOL
printf "${ENDCOLOR}"



cat <<EOL

EOL



# Roboto
curl -o roboto.zip https://fonts.google.com/download?family=Roboto
unzip roboto.zip -d roboto
rm -rf /usr/share/fonts/TTF/roboto
mv roboto /usr/share/fonts/TTF/

# Noto Sans
curl -o noto-sans.zip https://fonts.google.com/download?family=Noto%20Sans
unzip noto-sans.zip -d noto-sans
rm -rf /usr/share/fonts/TTF/noto-sans
mv noto-sans /usr/share/fonts/TTF/


# Fire Mono
curl -o fira-mono.zip https://fonts.google.com/download?family=Fira%20Mono
unzip fira-mono.zip -d fira-mono
rm -rf /usr/share/fonts/TTF/fira-mono
mv fira-mono /usr/share/fonts/TTF/


# Clear Sans
curl -o clear-sans.zip https://www.fontsquirrel.com/fonts/download/clear-sans
unzip clear-sans.zip -d clear-sans
rm -rf /usr/share/fonts/TTF/clear-sans
mv clear-sans /usr/share/fonts/TTF/


# Fire Sans
curl -o fira-sans.zip https://fonts.google.com/download?family=Fira%20Sans
unzip fira-sans.zip -d fira-sans
rm -rf /usr/share/fonts/TTF/fira_sans
mv fira-sans /usr/share/fonts/TTF/


# Roboto Slab
curl -o roboto-slab.zip https://fonts.google.com/download?family=Roboto%20Slab
unzip roboto-slab.zip -d roboto-slab
rm -rf /usr/share/fonts/TTF/roboto-slab
mv roboto-slab /usr/share/fonts/TTF/


# Overpass
curl -o overpass.zip https://fonts.google.com/download?family=Overpass
unzip overpass.zip -d overpass
rm -rf /usr/share/fonts/TTF/overpass
mv overpass /usr/share/fonts/TTF/


# Overpass Mono
curl -o overpass-mono.zip https://fonts.google.com/download?family=Overpass%20Mono
unzip overpass-mono.zip -d overpass-mono
rm -rf /usr/share/fonts/TTF/overpass-mono
mv overpass-mono /usr/share/fonts/TTF/


# Inter
rm -rf /usr/share/fonts/TTF/Inter-3.19
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
unzip Inter-3.19.zip -d Inter-3.19
rm -rf /usr/share/fonts/TTF/inter-3.19
mv Inter-3.19 /usr/share/fonts/TTF/


# Hack v3
rm -rf /usr/share/fonts/TTF/hack
wget -O hack-v3.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip hack-v3.zip -d hack-v3
mkdir hack
mv hack-v3/ttf/* hack
mv hack /usr/share/fonts/TTF/hack
fc-cache -f .
cd -


# Ubuntu Font Family
rm -rf /usr/share/fonts/TTF/ubuntu-font-family /usr/share/fonts/TTF/ubuntu-font-family-0.83
curl -o ubuntu-font-family.zip https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip
unzip ubuntu-font-family.zip -d ./
mv ubuntu-font-family-0.83 /usr/share/fonts/TTF/
fc-cache -f .
cd -


# JetBrains Mono Font Family
rm -rf /usr/share/fonts/TTF/jetbrains-mono JetBrainsMono-2.242 jetbrains-mono
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242 -d JetBrainsMono-2.242
mkdir jetbrains-mono
mv JetBrainsMono-2.242/fonts/ttf/** jetbrains-mono
mv jetbrains-mono /usr/share/fonts/TTF/jetbrains-mono
fc-cache -f .
cd -


# Install Monaco
rm -rf /usr/share/fonts/TTF/monaco
mkdir /usr/share/fonts/TTF/monaco
cd /usr/share/fonts/TTF/monaco
wget http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf
fc-cache -f .
cd -



printf "${GREEN}"
cat <<EOL
===============================================================
Congratulations, everything you wanted to install is installed!
===============================================================
EOL
printf "${ENDCOLOR}"



cat <<EOL

EOL
