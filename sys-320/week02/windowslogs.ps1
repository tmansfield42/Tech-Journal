function MichaelStart{

$page = Read-Host "page visited"
$code = Read-Host "HTTP Code (ex. 200)"
$browser = Read-Host "Browser (ex. Chrome or Firefox)"
#$browser = "Firefox"

$newvar = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern $browser | Select-String -Pattern $code | Select-String -CaseSensitive $page


$regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

$ips = $regex.Matches($newvar)

$new = $ips | Where-Object { $_.Value -ilike "*10.*" }


Write-Output "

Here are IP addresses that have visited $page, got a $code code and were using the $browser browser: "

$new.Value | Group-Object | Select-Object -ExpandProperty Name
}