
import-module ActiveDirectory
$MoveList = Import-Csv -Path "list.csv" 

$countPC = 0
foreach($data in $MoveList){
    $com = $data.computername
    $off = $data.office
    $TargetOU = "OU=xx, OU=xx,OU=xx,DC=xx,DC=xx,DC=xx,DC=xx"
    Try{ 
        Get-ADComputer $com | Move-ADObject -TargetPath $TargetOU
        $countPC++
    }catch{
        write-host "Error - Cannot move $com"
   }
}

write-host " $countPC  Computers has been moved "
