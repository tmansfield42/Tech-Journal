ip=$1
server=$2
echo "host,dnsserver"
for i in {1..254}; do
var="$ip.$i"
nslookup $var $server 2>/dev/null | grep -v "can't find" | grep -v "^$"
done
