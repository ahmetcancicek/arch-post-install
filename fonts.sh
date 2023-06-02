#!/bin/sh


# Roboto
curl -o roboto.zip https://fonts.google.com/download?family=Roboto
unzip roboto.zip -d roboto
rm -rf /usr/share/fonts/TTF/roboto
mv roboto /usr/share/fonts/TTF/fonts/roboto
