#!/bin/bash
if [ "$USER" = "liveuser" ] && [ ! -f "$HOME/Desktop/my-launcher.desktop" ]; then
  mkdir -p "$HOME/Desktop"
  cp /usr/share/applications/calamares.desktop "$HOME/Desktop/"
  chmod +x "$HOME/Desktop/calamares.desktop"
fi
