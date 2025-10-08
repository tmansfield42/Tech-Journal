. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)


clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "10 - Display at Risk Users`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 
    

    $myvar = 1

            function checkUser{

        $1 = (Get-Localuser).Name
        foreach($i in $1){
        if($name -match $i){
        Write-Host "Username is taken, try again"
        $script:myvar = 1
        return $true
        }
        else{
       $script:myvar = 2
        }
        }
        }



    while ($myvar -eq 1){
        $name = Read-Host -Prompt "Please enter the username for the new user"
        checkUser

        }
        checkPassword





    

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"



    if (-not (checkUser $name)) {
        Write-Host "User '$name' does not exist."  
    }
    else {
        removeAUser $name
        Write-Host "User: $name Removed." | Out-String
        
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

    if (-not (checkUser $name)) {
        Write-Host "User '$name' does not exist."  
    }
    else {

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }
    }

    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

    if (-not (checkUser $name)) {
        Write-Host "User '$name' does not exist."  
    }
    else {

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

          if (-not (checkUser $name)) {
        Write-Host "User '$name' does not exist."  
    }
    else {
        $daynumber = Read-Host "how many days?" 
        $userLogins = getLogInAndOffs $daynumber


        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }
    }

    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

          if (-not (checkUser $name)) {
        Write-Host "User '$name' does not exist."  
    }
    else {
        $daynumber = Read-Host "how many days?"
        $userLogins = getFailedLogins $daynumber 


        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }
    }
    elseif($choice -eq 10){
    
    $timeBack = Read-Host "How many days would you like to look back?"

    $testvariable = getFailedLogins $timeBack | Group-Object -Property User | Select-Object Name, Count | Sort-Object Count -Descending

    foreach ($i in $testvariable){
    if ($i.Count -gt 9){
    Write-Host $i.Name "is at risk"
    }

}


    }

 

}

    else{
    
    Write-Host "Invalid choice please try again"


}
}


