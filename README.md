# Overview
This repository contains a dockerfile capable of running any Jetbrains IDE internally, with gui on the host.

The repository is split into folders containing a build script to build an image for each specific IDE, as well as a 
script to run that container. 

Each container does not fight docker's empherial design. Rather, it will install the IDE in the image layer, and then save
the IDE's cache, configs, and plugins in docker volumes that are shared between all of the containers here. This means that you should be able to install new IDE versions and transfer just like normal. Your home directory will be mounted in it's normal place inside the 
container.

# Usage 

For example, to use clion:

1. `cd clion`

2. `./build.sh`

3. `./clion.sh`

Only the 3rd step needs to be used for as long as that IDE version needs to be used. If a new IDE version is being used,
simply repeat this process. Your settings should transfer normally.

# Updates

I will occasionally update this repository with up to date download links for each IDE, as it cannot be automated as far as I 
can tell. Feel free to submit a PR with updated links if you ever need it personally and want to contribute. To do this, just
change the JETBRAINS_IDE_URL variable in each build.sh.