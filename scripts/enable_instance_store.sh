#!/bin/bash

# Enable instance store build support.
#
# Cribbed in part from: https://groups.google.com/forum/#!topic/packer-tool/I6eGPTyhaXQ

DEBIAN_FRONTEND=noninteractive
UCF_FORCE_CONFFNEW=true
export UCF_FORCE_CONFFNEW DEBIAN_FRONTEND

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" dist-upgrade
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install ruby1.9.3
apt-get clean

# ec2-bundle-vol requires legacy grub and there should be no console setting
apt-get -y install grub
sed -i 's/console=hvc0/console=ttyS0/' /boot/grub/menu.lst

# To upgrade the kernel, we must edit the kernel and initrd values in the grub options
#
# The legal values can be found by running `ls /boot` *AFTER* upgrading the kernel.
#
# See also: https://ohthehugemanatee.org/2011/05/updating-kernels-for-amazon-aws.html/
KERNEL="3.19.0-31-generic"
sed -i "s#/boot/vmlinuz-.*-generic#/boot/vmlinuz-$KERNEL#" /boot/grub/menu.lst
sed -i "s#/boot/initrd.img-.*-generic#/boot/initrd.img-$KERNEL#" /boot/grub/menu.lst
# Also fix section titles
sed -i "s#3.13.0-66-generic#$KERNEL#" /boot/grub/menu.lst

# the above is sufficient to fix 12.04 but 14.04 also needs the following
sed -i 's/LABEL=UEFI.*//' /etc/fstab

# kpartx utility is required
apt-get -y install unzip kpartx

mkdir -p /var/tmp/ami_tools
mkdir -p /var/tmp/api_tools
mkdir -p /var/tmp/ec2/bin
mkdir -p /var/tmp/ec2/etc
mkdir -p /var/tmp/ec2/lib

export EC2_HOME=/var/tmp/ec2/bin
export PATH=$PATH:$EC2_HOME

cd /var/tmp/ami_tools
wget http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools-1.5.3.zip
unzip ec2-ami-tools-1.5.3.zip

cd /var/tmp/api_tools
wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
unzip ec2-api-tools.zip

cd /var/tmp
mv /var/tmp/ami_tools/ec2-ami-tools*/bin/* /var/tmp/ec2/bin/
mv /var/tmp/ami_tools/ec2-ami-tools*/lib/* /var/tmp/ec2/lib/
mv /var/tmp/ami_tools/ec2-ami-tools*/etc/* /var/tmp/ec2/etc/
mv /var/tmp/api_tools/ec2-api-tools*/bin/* /var/tmp/ec2/bin/
mv /var/tmp/api_tools/ec2-api-tools*/lib/* /var/tmp/ec2/lib/
# mv /var/tmp/api_tools/ec2-api-tools*/etc/* /var/tmp/ec2/etc/
