#!/usr/bin/env zsh

# HO.


set -euxo pipefail

# Example usage: ./manage-mr.sh delete ./virtualnetwork.yaml $(seq 1 10) | tee exp-virtualnetwork.log
OPERATION="$1"
TEMPLATE="$2"
NAMES=(${@:3})

echo "Experiment start: $(date)"

for n in "${NAMES[@]}"; do
	echo "Operating on suffix ${n}"
	cat "${TEMPLATE}" | sed "s/{{SUFFIX}}/${n}/g" | kubectl "${OPERATION}" -f -
	echo
done

