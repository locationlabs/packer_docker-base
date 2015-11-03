#!/bin/bash

# Update the apt cache before doing anything else.
#
# Note that running `apt-get upgrade` can be a poor idea in a non-interactive environment.
# Some of the base images (especially `chef/ubuntu-14.04`) will prompt get stuck during
# GRUB configuration.

echo "Updating apt..."
# apt-get update will fail intermittently during EBS builds; running this twice seems to work
apt-get -qy update
apt-get -qy update
