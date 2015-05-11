[![forthebadge](http://forthebadge.com/images/badges/powered-by-electricity.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/gluten-free.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/uses-badges.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/compatibility-betamax.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/as-seen-on-tv.svg)](http://forthebadge.com)
<br>[![Build Status](https://travis-ci.org/Korni22/packer-linux.svg?branch=master)](https://travis-ci.org/Korni22/packer-linux)

These are scripts that can be used to automatically create images for an OpenStack Environment.

Currently, only Scripts for CentOS 7 are considered stable, 6 is WIP, other Linux distributions will be added later.

## Usage:
`bash build.sh $dist $task`

Current options are:
</br>$dist = centos, ubuntu-14.04, ubuntu-15.04
</br>$task = build, pack, upload, deploy, complete