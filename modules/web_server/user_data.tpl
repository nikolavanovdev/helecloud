#!/bin/bash 
sudo su - root

yum update

yum install -y nfs-utils
yum install -y httpd

mkdir /shared_storage
efs_url="${efs_url}"
mount_target_ip="${mount_target_ip}"

IFS=","
export IFS

echo $mount_target_ip $efs_url >> /etc/hosts

mount -t nfs $efs_url:/ /shared_storage
mkdir /shared_storage/testmount

echo "<h1>Welcome to HeleWorld</h1>" | sudo tee /var/www/html/index.html

systemctl start httpd
systemctl enable httpd