#!/usr/bin/env bash

cache=/tmp/color-picker
mkdir -p "$cache"
touch "$cache/colors"

declare -i LIMIT=10
if [ "$(wc -l <"$cache/colors")" -gt 100 ]; then
    temp=$(mktemp)
    tail -n 10 "$cache/colors" >"$temp"
    mv "$temp" "$cache/colors"
fi

# json output for waybar
# Output for Waybar JSON module
[[ $# -eq 1 && $1 == "-j" ]] && {
    if [ ! -s "$cache/colors" ]; then
        echo '{ "text":"<span></span>", "tooltip":"<b>No Color History</b>" }'
        exit 0 # Exit gracefully if no history
    fi
    text="$(head -n 1 "$cache/colors")"
    mapfile -t allcolors < <(tail -n +2 "$cache/colors")
    tooltip="<b>Color Picker</b>\n\n"
    tooltip+="-> <b>$text</b>  <span color='$text'></span>\n"

    for i in "${allcolors[@]}"; do
        tooltip+="   $i  <span color='$i'></span>\n"
    done

    cat <<EOF
{ "text":"<span></span>", "tooltip":"$tooltip" }
EOF
    exit
}
command -v hyprpicker &>/dev/null || {
    notify-send "Color Picker" "Hyprpicker not found"
    exit 1
}
command -v wl-copy &>/dev/null || {
    notify-send "Color Picker" "wl-clipboard not found"
    exit 1
}

killall -q hyprpicker
color=$(hyprpicker -a | tr -d "\n")

# Suppress error message when cancelled
[[ -z "$color" ]] || exit 1

# Sometimes hyprpicker fails, prevent the fail string from entering the hist file
[[ "$color" =~ ^#?[0-9a-fA-F]{6}$ ]] || {
    notify-send "Color Picker" "Invalid color format: $color"
    exit 1
}

echo -e "$color" >>"$cache/colors"

magick -size 1x1 xc:"$color" /tmp/color-picker/last_picked.png
notify-send "Color Picker" "Color selected: $color" -i /tmp/color-picker/last_picked.png

# Maintain unique, limited history
prevColors="$(grep -vFx "$color" "$cache/colors" | head -n $((LIMIT - 1)))"
{
    echo "$color"
    echo "$prevColors"
} >"$cache/colors"

pkill -RTMIN+1 waybar

exit 0
