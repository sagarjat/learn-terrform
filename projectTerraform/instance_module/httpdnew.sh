 #!/bin/bash
echo ${var.pw} | sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y epel-release-latest-7.noarch.rpm
sudo yum install -y git python python-level python-pip openssl ansible 
