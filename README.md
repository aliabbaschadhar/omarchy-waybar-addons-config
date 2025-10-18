# Omarchy Waybar Config

This repository contains a minimal, modular Waybar configuration for Hyprland on Omarchy Linux. It is designed for easy use, sharing, and contribution.

## Overview

- **Purpose:** Provide a clean Waybar setup with useful custom modules for everyday productivity.
- **Modules:** Caffeine toggle and clipboard history (details in separate markdown files in the `modules` directory).
- **Compatibility:** Works best with Omarchy Linux and Hyprland, but adaptable to other Arch-based setups.

## Quick Start

1. **Clone this repo:**

   ```bash
   git clone https://github.com/aliabbaschadhar/omarchy-waybar-config.git ~/.config/waybar
   ```

2. **Make scripts executable after cloning:**

   ```bash
   chmod +x ~/.config/waybar/modules/*.sh
   ```

3. **Reload Waybar:**

   ```bash
    killall waybar && nohup waybar >/dev/null 2>&1 &          
   ```

## Modules

- **Caffeine Toggle:** See [`modules/CAFFEINE.md`](modules/CAFFEINE.md)
- **Clipboard History:** See [`modules/CLIPBOARD.md`](modules/CLIPBOARD.md)

## Contributing

Pull requests and issues are welcome! Please see module markdown files for details and usage.

## License

MIT
