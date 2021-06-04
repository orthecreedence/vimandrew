#!/bin/bash

function call_dunst() {
	call="dunstify -i /usr/share/icons/hicolor/48x48/apps/thunderbird.png"
	if [ "${DUNST_APP_NAME}" != "" ]; then
		call="${call} -a ${DUNST_APP_NAME}"
	fi
	if [ "${DUNST_URGENCY}" != "" ]; then
		call="${call} -u ${DUNST_URGENCY}"
	fi
	if [ "${DUNST_ID}" != "" ]; then
		call="${call} -r ${DUNST_ID}"
	fi
	${call} \
		--action="default,Open" \
		"${DUNST_SUMMARY}" \
		"${DUNST_BODY}"
}

ACTION=$(call_dunst)

case "${ACTION}" in
	"default")
		thunderbird -mail
		;;
esac

