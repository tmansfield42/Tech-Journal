param(
    [string]$ip,
    [string]$server
)


$result = foreach($i in 1..254){
Resolve-DnsName -DnsOnly "$ip.$i" -Server $server -ErrorAction Ignore
}

$result