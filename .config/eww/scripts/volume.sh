#!/usr/bin/bash

echo "{\"level\": $(pamixer --get-volume), \"muted\": $(pamixer --get-mute)}"

sh -c 'pactl subscribe | grep --line-buffered " sink " 2>/dev/null' | while read -r trash; do
    vol="$(pamixer --get-volume)"
    mute="$(pamixer --get-mute)"
    echo "{\"level\": $vol, \"muted\": $mute}"
done
