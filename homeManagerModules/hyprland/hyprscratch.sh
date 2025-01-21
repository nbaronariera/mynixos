#!/usr/bin/env bash

COMMAND=$1
CLASS=$2
WORKSPACE=$3

if [[ $(hyprctl clients | grep -v '"title":' | grep "class: $CLASS") ]]; then
    hyprctl dispatch togglespecialworkspace $WORKSPACE
else
    hyprctl dispatch togglespecialworkspace $WORKSPACE && hyprctl dispatch exec "$COMMAND"
fi
