useradd -m -d /home/sys265 -s /bin/bash sys265
mkdir /home/sys265/.ssh
cp SYS265/linux/public-keys/id_rsa.pub /home/sys265/.ssh/authorized_keys
chmod 700 /home/sys265/.ssh
chmod 600 /home/sys265/.ssh/authorized_keys
chown -R sys265:sys265 /home/sys265/.ssh
