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
do {
    $global:name = Read-Host "What name would you like this vm to be called?"
     if ($global:name -notmatch '^[a-zA-Z0-9]+$') {
         Write-Host "Invalid name. Please use alphanumeric characters only. Try again."
          }
        } while ($global:name -notmatch '^[a-zA-Z0-9]+$')
        return $global:name
}

Function Final(){
480Banner
$conf = Get-480Config -config_path "/home/michael/Tech-Journal/SEC-480/480.json"
480Connect -server $conf.vcenter_server
Write-Host "Selecting your VM"
$folder = Get-Folder -Name "BASEVM"
$global:selected_vm = Select-VM -folder $folder
Select-Snapshot
PickName

$linkedClone = "{0}.linked" -f $global:selected_vm
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $global:selected_vm -ReferenceSnapshot $global:selected_snap -VMHost $conf.esxi_host -Datastore $conf.datastore
$newvm = New-VM -Name $global:name -VM $linkedvm -VMHost $conf.esxi_host -Datastore $conf.datastore
$newvm | New-Snapshot -Name "Base"
$linkedvm | Remove-VM
}

Function New-Network(){
    $name = Read-Host "what would you like to call this new network?: "
    $vswitch = New-VirtualSwitch -VMHost 192.168.3.219 -Name $name
    New-VirtualPortGroup -VirtualSwitch $vswitch -Name $name

}

Function Get-IP(){
    $vms = Get-VM
    $index = 1
        foreach($i in $vms)
        {
            Write-Host [$index] $i.Name
            $index+=1
        }
          $pick = Read-Host "Which index number [x] do you wish to pick?"
        $macname= $vms[$pick -1]
        Write-Host "You picked " $macname.Name
    
    
    $mac = Get-NetworkAdapter -VM $macname
    $IP = Get-VMGuest -VM $macname
    Write-Host "MAC Address: " @($mac.MacAddress)[0], "IP: "@($IP.Ipaddress)[0]

    }

Function StoppaVM(){
    $vms = Get-VM
    $index = 1
        foreach($i in $vms)
        {
            Write-Host [$index] $i.Name
            $index+=1
        }
          $pick = Read-Host "Which index number [x] do you wish to TURN OFF?"
        $turnoff = $vms[$pick -1]
        Write-Host "You picked " $turnoff.Name

        Stop-VM -VM $turnoff.Name
}

Function StartaVM(){
    $vms = Get-VM
    $index = 1
        foreach($i in $vms)
        {
            Write-Host [$index] $i.Name
            $index+=1
        }
          $pick = Read-Host "Which index number [x] do you wish to TURN ON?"
        $turnon = $vms[$pick -1]
        Write-Host "You picked " $turnon.Name

    Start-VM -VM $turnon.Name

}

Function Set-Networkk(){

    $vms = Get-VM
    $index = 1
        foreach($i in $vms)
        {
            Write-Host [$index] $i.Name
            $index+=1
        }
          $pick = Read-Host "Which index number [x] do you wish to Set Network?"
        $macname= $vms[$pick -1]

        $networks = Get-NetworkAdapter -VM $macname
        $index = 1
        foreach ($i in $networks){

            Write-Host "[$index] name: $($i.Name) network name: $($i.NetworkName)  mac address: $($i.MacAddress)"
            $index += 1
        }
        $adapterpick = Read-Host "Which network adapter do you wish to update?"
        $adapter = $networks[$adapterpick - 1]

        $availablenet = Get-VirtualNetwork
        $index = 1
                foreach($i in $availablenet)
        {
            Write-Host [$index] $i.Name
            $index+=1
        }
          $netpick = Read-Host "Which index number [x] do you wish to assign ?"
        $net = $availablenet[$netpick -1] 

        Set-NetworkAdapter -NetworkAdapter $adapter -NetworkName $net 
        Write-Host "updated $($adapter.Name) on $($macname.Name) to $net"

    
        


}