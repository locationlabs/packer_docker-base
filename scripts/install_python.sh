#!/bin/bash

# Install Python and common dependencies.
#
# We expect just about every machine to have a working Python environment,
# both because we use Ansible for deployment and because we commonly write
# system utilities (e.g. `docker-rotate`) in Python.

echo "Installing python..."
apt-get install -y python build-essential libssl-dev libffi-dev python-dev python-setuptools

echo "Installing pip..."
sudo easy_install pip
