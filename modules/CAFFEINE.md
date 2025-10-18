# Caffeine Module for Waybar

This module lets you toggle Hyprland's idle daemon (`hypridle`) directly from Waybar, preventing your screen from locking or sleeping when you need to stay active.

## Features

- **☕ Icon:** Caffeine enabled (idle disabled)
- **💤 Icon:** Caffeine disabled (idle active)
- **Click to toggle:** Instantly enable/disable idle
- **Tooltip:** Shows current status

## Installation

### 1. Copy the Script

Place `caffeine.sh` in your Waybar modules directory:

```bash
cp caffeine.sh ~/.config/waybar/modules/caffeine.sh
chmod +x ~/.config/waybar/modules/caffeine.sh
```

### 2. Add to Waybar Config

Edit your `config.jsonc` and add the module definition:

```jsonc
"custom/caffeine": {
  "exec": "~/.config/waybar/modules/caffeine.sh status",
  "interval": 5,
  "on-click": "~/.config/waybar/modules/caffeine.sh && pkill -RTMIN+10 waybar",
  "return-type": "json",
  "signal": 10
},
```

Then add `"custom/caffeine"` to your `modules-right` array:

```jsonc
"modules-right": [
  "group/tray-expander",
  "custom/caffeine",
  ...
]
```

### 3. Reload Waybar

```bash
killall waybar && nohup waybar >/dev/null 2>&1 &          
```

## How It Works

- **Status check:** The script outputs JSON for Waybar, showing ☕ or 💤 depending on `hypridle` status.
- **Toggle:** Clicking the icon toggles the `hypridle` service and updates the icon immediately.
- **Interval:** The icon refreshes every 5 seconds to stay in sync.

## Troubleshooting

- **Icon not showing?**
  - Make sure the script is executable: `chmod +x ~/.config/waybar/modules/caffeine.sh`
  - Check your config for typos
- **No effect?**
  - Ensure `hypridle` is installed and enabled for your user
  - Check service status: `systemctl --user status hypridle.service`
- **Want a different icon or tooltip?**
  - Edit the JSON output in the script to customize

## Example Script

```bash
#!/bin/bash
# If "status" argument is provided, just check status without toggling
if [ "$1" = "status" ]; then
  if systemctl --user is-active --quiet hypridle.service; then
    echo '{"text": "💤", "tooltip": "Caffeine disabled (idle active)"}'
  else
    echo '{"text": "☕", "tooltip": "Caffeine enabled (idle disabled)"}'
  fi
  exit 0
fi
# Toggle the service
if systemctl --user is-active --quiet hypridle.service; then
  systemctl --user stop hypridle.service
  echo '{"text": "☕", "tooltip": "Caffeine enabled (idle disabled)"}'
else
  systemctl --user start hypridle.service
  echo '{"text": "💤", "tooltip": "Caffeine disabled (idle active)"}'
fi
```

## Customization

- Change icons or tooltip text in the script for your own style
- Adjust the refresh interval in `config.jsonc` if needed

## License

MIT
