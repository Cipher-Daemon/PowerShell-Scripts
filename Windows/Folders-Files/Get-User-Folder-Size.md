# Get Users Folder Size

## For only user root folders

```powershell
$ErrorActionPreference= 'silentlycontinue'
$Data = @()
$AllUserFolder = Get-ChildItem c:\users\ -Directory |?{$_.Name -ne "Public"}
$Computername = hostname
Foreach ($UserFolder in $AllUserFolder){
    $Foldersize = (Get-ChildItem -Recurse c:\users\$UserFolder\|measure-object -sum length).sum
    $Bytes = '{0:N0}' -f $Foldersize
    if ($Foldersize -ne $Null -and $Foldersize -ne 0){
            $Row = "" | Select ComputerName,username,FolderSizeInBytes
            $Row.Computername = $Computername
            $Row.username = $UserFolder.Name
            $Row.FolderSizeInBytes = $Bytes
            $Data += $Row
        }
    }

$Data|out-gridview
```

## For Subroot folders

```powershell
$ErrorActionPreference= 'silentlycontinue'
$Data = @()
$AllUserFolder = Get-ChildItem c:\users\ -Directory |?{$_.Name -ne "Public"}
$Computername = hostname
Foreach ($UserFolder in $AllUserFolder){
    $Folders = Get-ChildItem c:\users\$UserFolder\ -Directory

    foreach ($Folder in $Folders){
    $FolderFullName = $Folder.fullname
    $RootUserFolder = (Get-ChildItem -Recurse $Folder.fullname|Measure-Object -sum length -ErrorVariable SumError).sum
        if ($SumError){
        write-host -foregroundcolor red "Cannot get sum for $Folderfullname either not accessable or nothing is there!"
        }
    $Bytes = '{0:N0}' -f $RootUserFolder
    if ($RootUserFolder -ne $Null -and $RootUserFolder -ne 0){
            write-host "$FolderFullName is $Bytes Bytes"
            $Row = "" | Select ComputerName,username,Folder,SizeInBytes
            $Row.Computername = $Computername
            $Row.username = $UserFolder.Name
            $Row.Folder = $FolderFullName
            $Row.SizeInBytes = $Bytes
            $Data += $Row
        }
    }
}

$Data|out-gridview
```
