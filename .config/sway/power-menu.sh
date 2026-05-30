#!/bin/bash
choice=$(printf "  Shutdown\n  Reboot\n  Suspend\n  Lock\n  Logout" | fuzzel --dmenu -l 5 -p "Power: ")
case $choice in
    "  Shutdown") shutdown now ;;
    "  Reboot") reboot ;;
    "  Suspend") systemctl suspend ;;
    "  Lock") swaylock -f -c 1a1e24 ;;
    "  Logout") swaymsg exit ;;
esac
