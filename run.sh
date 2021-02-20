#!/bin/sh


# won't work, quoting problems
# https://github.com/containers/podman/issues/9446
# --env-file=./.env

set -o allexport
. ./.env
set +o allexport

podman run                        \
	-ti                             \
	-v "$PWD/aports:/root/aports"   \
	--group-add=abuild              \
	--env="HOST_*"                  \
	--cap-add=cap_net_raw           \
	localhost/alpine-packaging-image /bin/sh
