function 480Banner()
{
Write-Host "Hello SYS480 Devops"
}

Function 480Connect([string] $server)
{

$conn = $global:DefaultVIServer

if($conn) {

    $msg = "Already connected to: {0}" -f $conn
        Write-Host -ForegroundColor Green $msg
        }
        else {
            $conn = Connect-VIServer -Server $server
                #if this fails let vcenter handle the exception 
                }
                }

Function Get-480Config([string] $config_path)
{

    $conf=$null
    if(Test-Path $config_path)
    {
        $conf = (Get-Content -Raw -Path $config_path | ConvertFrom-Json)
        $msg = "Using configuration at {0}" -f $config_path
        Write-Host -ForegroundColor Green $msg
    }else{
        Write-Host -ForegroundColor Yellow "No Configuration"
    }
    return $conf
}

Function Select-VM([string] $folder)
{

    $global:selected_vm=$null
    try {
        $vms = Get-Vm -Location $folder
        $index = 1
        foreach($vm in $vms)
        {
            Write-Host [$index] $vm.Name
            $index+=1
        }
        $pick_index = Read-Host "Which index number [x] do you wish to pick?"
        if($pick_index -gt 4){
            Write-Host "please pick a real vm"
            break
        }
        $global:selected_vm = $vms[$pick_index -1]
        Write-Host "You picked " $global:selected_vm.Name
        $global:selected_vm = $vms[$pick_index -1]
        return $global:selected_vm.Name
    }
    catch {
        Write-Host "Invalid Folder: $folder" -ForegroundColor Red
    }
}

Function Select-Snapshot([string] $selected_vm_name)
{

    $global:selected_snap=$null
    try {
        $vmss = Get-Snapshot -VM $global:selected_vm
        $index = 1
        foreach($snap in $vmss)
        {
            Write-Host [$index] $snap.Name
            $index+=1
        }
        $pick_indexx = Read-Host "Which index number [x] do you wish to pick?"
        if($pick_indexx -gt 4){
            Write-Host "please pick a real snapshot"
            break
        }
        $global:selected_snap = $vmss[$pick_indexx -1]
        Write-Host "You picked " $global:selected_snap.Name
        return $global:selected_snap
    }
    catch {
        Write-Host "Invalid snapshot: $global:selected_snap" -ForegroundColor Red
    }
}

Function PickName([string] $name)
{
    $global:name = Read-Host "What name would you like this vm to be called?"
    return $global:name
}