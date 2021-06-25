 #!/bin/bash
echo ${var.pw} | sudo yum -y install httpd
sudo chmod 777 -R /var/www/html/
sudo echo "<em style='color:blue;'>This Page is served from :`hostname -f`</em>" >> /var/www/html/index.html
sudo service httpd start