#!/bin/sh

podman run                        \
	-ti                             \
	-v "$PWD/aports:/root/aports"   \
	--group-add=abuild              \
	--cap-add=cap_net_raw           \
	localhost/alpine-build /bin/sh
