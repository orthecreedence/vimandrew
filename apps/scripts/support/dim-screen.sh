#!/bin/bash

get_brightness() {
	#brightnessctl g
	percent=$((100 * `brightnessctl g` / `brightnessctl m`))
	echo $percent
}

set_brightness() {
	brightnessctl set $1 > /dev/null
}

dim_screen() {
	cur=$(get_brightness)

	local level
	for level in $(eval echo {$(get_brightness)..10}); do
		set_brightness ${level}%
		sleep 0.03
	done
}

trap 'exit 0' TERM INT
trap "set_brightness $(get_brightness)%; kill %%" EXIT
dim_screen
sleep 2147483647 &
wait
