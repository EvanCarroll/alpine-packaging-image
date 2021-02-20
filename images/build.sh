#!/bin/zsh

set -o allexport
. ./.env
set +o allexport

CTR=$(buildah from alpine:3)
MNT=$(buildah mount "$CTR")

cat <<EOF
	CONTAINER : "$CTR"
	MOUNT     : "$MNT"
EOF

CTR_HOME="$MNT/root"

if mkdir keys 2> /dev/null; then
	openssl genrsa -out "keys/$HOST_EMAIL.rsa" 2048
	openssl rsa -in "keys/$HOST_EMAIL.rsa.pub" -pubout -out "keys/$HOST_EMAIL.rsa.pub"
fi

if [ ! -d "./aports" ]; then
	git clone https://gitlab.alpinelinux.org/alpine/aports
	( cd aports; git pull origin master );
fi

mkdir -p "$CTR_HOME" "$CTR_HOME/.abuild/"
cp "$HOME/.gitconfig"      "$CTR_HOME"
cp "keys/$HOST_EMAIL.rsa"  "$CTR_HOME/.abuild/"

mkdir -p "$MNT/etc/apk/keys/"
cp "keys/$HOST_EMAIL.rsa.pub"   "$MNT/etc/apk/keys/"
cp "files/abuild.conf"          "$MNT/etc/abuild.conf"

buildah run "$CTR" -- sh <<EOF
	apk add alpine-sdk git sudo sed shadow vim atools
	chgrp abuild /var/cache/distfiles
	chmod g+w    /var/cache/distfiles
EOF

buildah config --workingdir "/root/aports" "$CTR"
buildah commit "$CTR" alpine-packaging-image
