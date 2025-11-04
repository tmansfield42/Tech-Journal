cat /var/log/apache2/access.log | cut -d' ' -f1,7 | tr -d '/'
