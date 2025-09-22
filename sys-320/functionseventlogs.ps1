function start-script{

$days = Read-Host "input integer days"

$logins = (Get-EventLog System -After (get-date).AddDays(-$days) | Where-Object { $_.InstanceId -eq 7001 -or $_.InstanceId -eq 7002 -or $_.EventId -eq 6006 -or $_.EventId -eq 6005 } )

$loginstable = @()
$shutdowntable = @()
$startuptable = @()

foreach ($i in $logins){

try {

$SID = New-Object System.Security.Principal.SecurityIdentifier($i.ReplacementStrings[1]) -ErrorAction SilentlyContinue
$objUser = $SID.Translate([System.Security.Principal.NTAccount]) 
} catch {


if ($i.InstanceId -eq 7001){
$loginstable += [PSCustomObject]@{"Time" = $i.TimeGenerated
                    "Id" = $i.InstanceId
                 "Event" = "Logon"
                  "User" = $objUser.Value
                  }

}
elseif ($i.InstanceId -eq 7002){
$loginstable += [PSCustomObject]@{"Time" = $i.TimeGenerated
                    "Id" = $i.InstanceId
                 "Event" = "Logoff"
                  "User" = $objUser.Value
                  }


}
elseif ($i.EventId -eq 6006){
$shutdowntable += [PSCustomObject]@{"Time" = $i.TimeGenerated
                    "Id" = $i.EventId
                 "Event" = "ShutDown"
                  "User" = "System"
                  }

}
elseif ($i.EventId -eq 6005){
$startuptable += [PSCustomObject]@{"Time" = $i.TimeGenerated
                    "Id" = $i.EventId
                 "Event" = "StartUp"
                  "User" = "System"
                  }




}
}
}
}
$loginstable
$shutdowntable 
$startuptable 
