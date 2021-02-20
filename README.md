Alpine Image Builder for Packaging
=====

This is a simply a container meant to be run rootless to ease alpine package
creation. It installs the tools needed, and pulls down the alpine [`abuild`
repo](https://github.com/alpinelinux/abuild).

This is pretty simple,

* Edit the `/.env` file
* Run `rootless.sh` to create the rootless container
* Run `run.sh` to jump into it and [get to packaging!](https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package#Creating_an_APKBUILD_file)

How does it work?
=====

When you're packaging you can mutilate an entire system trying different
things. Containers are great for "restoring" state without messing up your
machine. You can be totally careless with them, destroy and recreate them.

This repository pulls down `abuild` repository linked above. That's where your
build files like the `APKBUILD` reside (the Alpine equivalent of RHEL Spec
files). This gets volume mounted into the container with the `run.sh` script.
It's the only state that remains from one iteration of `run.sh` to another.

Notes on Root (UID=0)
=====

Many of the [Alpine build utilities will error if you try to run them as root](https://unix.stackexchange.com/q/635291/3285). **This error is safe to
ignore!** as none of the utilities actually run as root with this
configuration. When logged into a rootless container you have uid=0 from the
perspective of the container, but you're actually mapped back to the user that
executed `podman run`. Some of the utilities will require a capital `-F` flag
to force them to permit root. This is fine.
