#!/bin/bash

# This script toggles hypridle and outputs JSON for Waybar

# If "status" argument is provided, just check status without toggling
if [ "$1" = "status" ]; then
  if systemctl --user is-active --quiet hypridle.service; then
    # Idle active => caffeine OFF (use Nerd Font bed icon)
    echo '{"text": "", "tooltip": "Caffeine disabled (idle active)"}'
  else
    # Idle disabled => caffeine ON (use Nerd Font coffee icon)
    echo '{"text": "", "tooltip": "Caffeine enabled (idle disabled)"}'
  fi
  exit 0
fi

# Toggle the service
if systemctl --user is-active --quiet hypridle.service; then
  systemctl --user stop hypridle.service
  echo '{"text": "", "tooltip": "Caffeine enabled (idle disabled)"}'
else
  systemctl --user start hypridle.service
  echo '{"text": "", "tooltip": "Caffeine disabled (idle active)"}'
fi

