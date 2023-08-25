```powershell
$filePath = "C:\Windows\System32\LogFiles\Firewall\firewall.log"
$NewFile = "c:\temp\fwlog.csv"

# Read the content of the file
$fileContent = Get-Content $filePath

# Skip the first three lines and write the remaining content back to the file
$NegativeCSV = $fileContent[5..($fileContent.Length - 1)]

$PositiveCSV = $NegativeCSV -replace [char]0x0020,[char]0x002c


$Header = "date,time,action,protocol,src-ip,dst-ip,src-port,dst-port,size,tcpflags,tcpsyn,tcpack,tcpwin,icmptype,icmpcode,info,path,pid"

$Header | Add-Content $NewFile

$PositiveCSV|Add-Content $NewFile
```
