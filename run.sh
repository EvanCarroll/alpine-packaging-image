#!/bin/sh

podman run                        \
	-ti                             \
	-v "$PWD/aports:/root/aports"   \
	--group-add=abuild              \
	--cap-add=cap_net_raw           \
	--env-file=./.env               \
	localhost/alpine-packaging-image /bin/sh
