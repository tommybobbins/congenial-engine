# congenial-engine
Terraform AWS EC2 instance, Apache webserver IPv6 subnet. Copies content from an S3 bucket to populate the /data/sites

Based on a t3.nano which has 500MB of memory, this can lead to OOMs when performing a yum install. Added a temporary swapfile to work around this in the userdata.sh.


