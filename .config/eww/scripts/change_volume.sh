#!/usr/bin/bash

if [ "$1" = "down" ]; then
    pamixer -d 1
elif [ "$1" == "up" ]; then
    pamixer -i 1
else
    echo "doomed"
fi
