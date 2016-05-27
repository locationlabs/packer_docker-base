#!/bin/bash

# Install ansible (and its dependencies).
#
# Ansible must be installed on any machine using Packer's "ansible-local" provisioner.
#
# Dependencies:
#
#   - `install_python.sh`

echo "Installing ansible>=1.9.4,<2.0..."
pip install "ansible>=1.9.4,<2.0"
