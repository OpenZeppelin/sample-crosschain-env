#!/bin/bash

check() {
	curl \
		--output /dev/null \
		--silent \
		--fail \
		-X POST \
		-H "Content-Type: application/json" \
		--data '{"jsonrpc":"2.0","method":"net_status","params":[],"id":1}' \
		${ENDPOINT:-127.0.0.1:8545}
	return $?
}

while [[ $# -gt 0 ]];
do
	case $1 in
		-e|--endpoint)
			ENDPOINT=$2
			shift
			shift
			;;
		-v|--verbose)
			VERBOSE=true
			shift
			;;
		-w|--wait)
			WAIT=true
			shift
			;;
		--help)
			echo "Usage: $0 [OPTION]"
			echo "Check if an ethereum node is ready"
			echo "  -e, --endpoint [URL]      endpoint to query (default: 127.0.0.1:8545)"
			echo "  -v, --verbose             enable verbose output"
			echo "  -w, --wait                activelly wait for the enpoint to become available"
			exit 0
			;;
		*)
			echo "Unkown argument $1"
			exit 1
			;;
	esac
done

if [[ -n $WAIT ]];
then
	until check;
	do
		[[ -n $VERBOSE ]] && printf '.'
		sleep .1
	done
	[[ -n $VERBOSE ]] && echo 'ready'
	exit 0
else
	check
	if [[ $? -eq 0 ]];
	then
		[[ -n $VERBOSE ]] && echo "ready"
	else
		[[ -n $VERBOSE ]] && echo "not ready"
		exit 1
	fi
fi