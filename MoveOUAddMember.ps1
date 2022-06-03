
$GLOBAL:PackageName = "batch_move_ou"
$GLOBAL:criptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition -parent
$global:LastExitCode = ""
."$criptRoot\support\spprtfnctns_.ps1"

import-module ActiveDirectory
$MoveList = Import-Csv -Path "$criptRoot\moveou_list.csv" 

$countPC = 0
foreach($data in $MoveList){
    $com = $data.computername
    $off = $data.office
    $TargetOU = "OU=xx, OU=xx,OU=xx,DC=xx,DC=xx,DC=xx,DC=xx"
    Try{ 
        Get-ADComputer $com | Move-ADObject -TargetPath $TargetOU
        IW-LogEntry "$com moved to $TargetOU"
           $countPC++
    }catch{
        IW-LogEntry "Error - Cannot move $com"
   }
}

IW-LogEntry " $countPC  Computers has been moved "
