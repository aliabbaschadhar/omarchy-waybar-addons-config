#!/bin/bash
# Show clipboard history and copy selected entry

if [ "$1" = "icon" ]; then
  echo '{"text": "📋", "tooltip": "Clipboard history"}'
  exit 0
fi

selected=$(cliphist list | wofi --show dmenu -p "Clipboard history")
if [ -n "$selected" ]; then
  # Copy to both CLIPBOARD and PRIMARY selections
  decoded=$(echo -n "$selected" | cliphist decode)
  printf '%s' "$decoded" | wl-copy
  printf '%s' "$decoded" | wl-copy --primary
fi
