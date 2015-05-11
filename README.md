[![Build Status](https://travis-ci.org/Korni22/packer-linux.svg?branch=travis)](https://travis-ci.org/Korni22/packer-linux)

These are scripts that can be used to automatically create images for an OpenStack Environment.

Currently, only Scripts for CentOS 7 are considered stable, 6 is WIP, other Linux distributions will be added later.

## Usage:
`bash build.sh $dist $task`

Current options are:
</br>$dist = centos, ubuntu-14.04, ubuntu-15.04
</br>$task = build, pack, upload, deploy, complete