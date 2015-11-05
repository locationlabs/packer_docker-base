## Overview

This repository contains configurations for using Packer to build machine images that define
a base Docker image, including AMIs (for AWS) and VirtualBox-based Vagrant boxes.

Boxes provisioned with these images will have the Docker engine running and ready to go as well
 as some base utilities and configurations that we find useful in all our environments.

This project attempts to create *equivalent* images across providers by starting from *similar*
base images and applying the *same* provisioning steps using Ansible. This approach allows us to
switch between AWS and Vagrant with little overhead and push common elements of Ansible-based
deploys into the initial image to save time during deployment.


## Subtrees
This repo is using git subtrees to pull in dependencies. Why not submodules?
Well, they're horrible for one. Subtrees are much simpler, you don't need
to run any extra commands, just clone as usual and everything is there.

### packer-ansible subtree
Subtree for https://github.com/locationlabs/packer-ansible

To update run the following:

```
git subtree pull --prefix ansible https://github.com/locationlabs/packer-ansible master --squash
```

Always use the `master` branch of [packer-ansible][] so that you're getting the latest
released version (or use a tag).

### chef/bento subtree
The vagrant image is heavily based on [Chef]'s excellent work on their [bento][]
packer definitions. So much so that we use their scripts directly from our definitions.

To update the `bento` subtree:
```
git subtree pull --prefix bento https://github.com/chef/bento.git 2.2.2 --squash
```

Only use [bento release tags][] when updating `bento`.

[packer-ansible]: https://github.com/locationlabs/packer-ansible
[bento]: https://github.com/chef/bento
[bento release tags]: https://github.com/chef/bento/tags
[Chef]: http://chef.io
