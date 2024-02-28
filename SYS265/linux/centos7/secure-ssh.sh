#secure-ssh.sh
#author gmcyber
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled form the remote repo
#rmeotes roots ability to ssh in
echo -n "Enter user: "
read user
useradd -m -d /home/$user -s /bin/bash $user
mkdir /home/$user/.ssh
cp SYS265/linux/public-keys/id_rsa.pub /home/$user/.ssh/authorized_keys
chmod 700 /home/$user/.ssh
chmod 600 /home/$user/.ssh/authorized_keys
chown -R $user:$user /home/$user/.ssh
