#!/bin/bash -e

/opt/dump1090/sdrplay_apiService &
P1=$!
/opt/dump1090/dump1090 "$@" &
P2=$!
wait $P1 $P2