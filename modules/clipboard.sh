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
