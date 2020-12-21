#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
polybar -c ~/.config/polybar/config-andrew -r primary >/tmp/polybar1.log 2>&1 & disown

echo "Bars launched..."
