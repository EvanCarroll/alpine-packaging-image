Alpine Container for Packging
====

This is a simply container ment to be run rootless to ease alpine image
creation. It installs the tools needed, and pulls down the alpine abuild repo.

This is pretty simple,

* Edit the `/.env` file
* Run `rootless.sh` to create the rootless container
* Run `run.sh` to jump into it and get to packaging!
