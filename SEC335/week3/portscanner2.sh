hostfile=$1
portfile=$2
echo "host,port"
for host in {1..254}; do
newvar="$hostfile.$host"
timeout .1 bash -c "echo >/dev/tcp/$newvar/$portfile" 2>/dev/null && echo "$newvar,$portfile"
done
