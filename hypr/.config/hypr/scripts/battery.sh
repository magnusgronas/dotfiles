#!/usr/bin/env bash

PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)
STATE=$(cat /sys/class/power_supply/BAT0/status)

BAT_ICONS=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
# TODO: Make colors work, probably need to make a matugen template
# BAT_COLOR="\$surface_bright"

if [[ $STATE == "Charging" ]]; then
  ICON="󰂄"
else
  INDEX=$(((PERCENTAGE - 1) / 10))
  ICON=${BAT_ICONS[INDEX]}
  # if [[ $INDEX -lt 3 ]]; then
  #   BAT_COLOR="\$error"
  # fi
fi

# echo "<span>$TIME</span> <span foreground='$BAT_COLOR'>$ICON $PERCENTAGE%</span>"
echo "<span>$PERCENTAGE $ICON</span>"
exit 0
