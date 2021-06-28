#!/bin/bash -ex
# Adding swap temporarily in case of using t3.nano
dd if=/dev/zero of=/var/cache/swapfile bs=1M count=1024;
chmod 600 /var/cache/swapfile;
mkswap /var/cache/swapfile;
swapon /var/cache/swapfile;
free -m > /var/tmp/swap.txt
yum update;
yum upgrade -y;
yum install -y httpd boxes pwgen;
sed -i 's/^#Port 22/Port 2020/g' /etc/ssh/sshd_config;
systemctl restart sshd;
hostnamectl set-hostname ${host_name};
timedatectl set-timezone Europe/London;
amazon-linux-extras install epel -y;
mkdir -p /data/sites;
ln -s /data/sites /home/sites;
aws s3 cp s3://${bucket_name}/mail.tar.gz /usr/local/src/;
cd /usr/local/src/; tar zxf mail.tar.gz;
cd /usr/local/src/MAIL/SCRIPTS; ./install.sh;
aws s3 cp s3://${bucket_name}/sites.tar.gz /data/;
cd /data; tar xzf sites.tar.gz;
aws s3 cp s3://${bucket_name}/le.tar.gz /data;
cd /etc; tar xzf /data/le.tar.gz;
aws s3 cp s3://${bucket_name}/backup_homer.sh /usr/local/bin/;
chmod 777 /usr/local/bin/*;
aws s3 cp s3://${bucket_name}/crontab /var/tmp/crontab;
crontab /var/tmp/crontab;
systemctl enable httpd --now;
sleep 10;
yum upgrade -y;
free -m >> /var/tmp/swap.txt
swapoff /var/cache/swapfile;
rm /var/cache/swapfile;
free -m >> /var/tmp/swap.txt
