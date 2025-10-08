. (Join-Path $PSScriptRoot Event-Logs.ps1)
. ("C:\Users\Michael\Tech-Journal\sys-320\week02\apachelogs.ps1")



$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - last 10 apache logs`n"
$Prompt += "2 - 10 failed logins`n"
$Prompt += "3 - At risk users`n"
$Prompt += "4 - Go to champlain.edu`n"
$Prompt += "5 - Exit`n"



$operation = $true


while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 


if($choice -eq 4){
$chrome = Get-Process -Name "*chrome*" -ErrorAction SilentlyContinue
if ($chrome) {

Stop-Process -name "*chrome*" -Force

}else{
Start-Process www.champlain.edu

}
}

if($choice -eq 1){

$global:tableRecords


}

if($choice -eq 3){

$timeback = 100

    $testvariable = getFailedLogins $timeBack | Group-Object -Property User 

    foreach ($i in $testvariable){
    Write-Host $i.Name "Failed login"
    }


}


if($choice -eq 3){

 $timeback = 100

    $testvariable = getFailedLogins $timeBack | Group-Object -Property User 

    foreach ($i in $testvariable){
    if ($i.Count -gt 9){
    Write-Host $i.Name "is at risk"
    }

}

}

}
}