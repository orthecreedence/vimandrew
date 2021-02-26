#!/bin/bash

CMD="$1"
COLOR_PRIMARY="#999"
COLOR_SECONDARY="#d3869b"

function display {
	if [ "$(dunstctl is-paused)" == "false" ]; then
		echo "%{F${COLOR_PRIMARY}}%{F-}"
	else
		echo "%{F${COLOR_SECONDARY}}%{F-}"
	fi
}

case "${CMD}" in
	toggle)
		dunstctl set-paused toggle
		;;
	display)
		display
		;;
esac

