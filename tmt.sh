#!/bin/bash -ex

if [[ -z $FOREMAN_BASE_URL ]] ; then
	if [[ -n $TMT_TOPOLOGY_BASH ]] ; then
		. "$TMT_TOPOLOGY_BASH"
		FOREMAN_BASE_URL=https://${TMT_GUESTS['quadlet.hostname']}/
	else
		echo "Provide $FOREMAN_BASE_URL" >&2
		exit 1
	fi
fi

if ! command -v pytest &> /dev/null ; then
	pip3 install --user -r requirements.txt
	echo "$PATH"
	# In case ~/.local/bin was just created
	hash -r
fi

pytest --base-url "${FOREMAN_BASE_URL}" "$@"
