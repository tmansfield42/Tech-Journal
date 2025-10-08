<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

        #                Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true



function checkPassword{
$script:myvar2 = 1

$global:password = 

function checkPassword1{



if ($plain.length -lt 6){

Write-Host "Password must be 6 chars, try again"

}
else{ 
    if ($plain -match '(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9])'){ #had gpt help me w/ regex

    $global:password = ConvertTo-SecureString $plain -AsPlainText -Force
    $script:myvar2 = 2
    }
    else{
    "Needs special character, number and a letter" 
    }
}
return $true
}


while ($myvar2 -eq 1){

$plain = Read-Host "Provide user password: "

checkPassword1

}

}