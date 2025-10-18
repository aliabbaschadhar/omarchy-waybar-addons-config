# Clipboard History Module for Waybar

This module adds a clipboard history menu to Waybar, allowing you to view, search, and restore previous clipboard entries with a single click.

## Features

- 📋 Icon in Waybar
- Click to open clipboard history menu (using `wofi`)
- Select an entry to copy it back to clipboard and primary selection
- Case-insensitive search

## Installation

### 1. Copy the Script

Place `clipboard.sh` in your Waybar modules directory:

```bash
cp clipboard.sh ~/.config/waybar/modules/clipboard.sh
chmod +x ~/.config/waybar/modules/clipboard.sh
```

### 2. Add to Waybar Config

Edit your `config.jsonc` and add the module definition:

```jsonc
"custom/clipboard": {
  "exec": "~/.config/waybar/modules/clipboard.sh icon",
  "interval": 10,
  "on-click": "~/.config/waybar/modules/clipboard.sh",
  "return-type": "json"
},
```

Then add `"custom/clipboard"` to your `modules-right` array:

```jsonc
"modules-right": [
  ...
  "custom/clipboard",
  ...
]
```

### 3. Enable Clipboard History Services

To automatically save clipboard history, create these systemd user services:

**~/.config/systemd/user/cliphist-store.service**

```ini
[Unit]
Description=Store clipboard history via cliphist (CLIPBOARD selection)
After=graphical-session.target

[Service]
ExecStart=/bin/sh -c 'wl-paste --type text --watch sh -c "sleep 0.3 && cliphist store"'
Restart=on-failure

[Install]
WantedBy=graphical-session.target
```

**~/.config/systemd/user/cliphist-store-primary.service**

```ini
[Unit]
Description=Store PRIMARY selection via cliphist (middle-click selection)
After=graphical-session.target

[Service]
ExecStart=/bin/sh -c 'wl-paste --primary --type text --watch sh -c "sleep 0.3 && cliphist store"'
Restart=on-failure

[Install]
WantedBy=graphical-session.target
```

Enable and start:

```bash
systemctl --user daemon-reload
systemctl --user enable --now cliphist-store.service cliphist-store-primary.service
```

### 4. Reload Waybar

```bash
killall waybar && nohup waybar >/dev/null 2>&1 &          
```

## How It Works

- The script shows a 📋 icon in Waybar.
- Clicking the icon opens a searchable menu of clipboard history (via `wofi`).
- Selecting an entry copies it back to both clipboard and primary selection (so you can paste with Ctrl+V or middle-click).

## Troubleshooting

- **No history?**
  - Make sure the systemd services above are running
  - Check with: `systemctl --user status cliphist-store.service`
- **Menu not opening?**
  - Ensure `wofi` is installed
  - Try running: `cliphist list | wofi --show dmenu`
- **Script not working?**
  - Make sure it is executable: `chmod +x ~/.config/waybar/modules/clipboard.sh`

## Example Script

```bash
#!/bin/bash
# Show clipboard history and copy selected entry
if [ "$1" = "icon" ]; then
  echo '{"text": "📋", "tooltip": "Clipboard history"}'
  exit 0
fi
selected=$(cliphist list | wofi --show dmenu -p "Clipboard history" -i)
if [ -n "$selected" ]; then
  # Copy to both CLIPBOARD and PRIMARY selections
  # Use cliphist decode to get the full original content
  cliphist decode <<<"$selected" | wl-copy
  cliphist decode <<<"$selected" | wl-copy --primary
fi
```

## Customization

- Change the icon or tooltip in the script for your own style
- Use a different menu tool (e.g., `rofi`, `bemenu`) if preferred
- Adjust the refresh interval in `config.jsonc` if needed

## License

MIT
