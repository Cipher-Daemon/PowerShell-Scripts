# TLS Audit

Before you start this the following registry key must be set in order to get the useful information that you need

```cmd
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL
```

After you go to the following path you must edit the REG_DWORD Value

```CMD
EventLogging
```

Valid Values:

|value|Description|
|---|---|
|0x0000|	Do not log|
|0x0001	|Log error messages|
|0x0002	|Log warnings|
|0x0003	|Log warnings and error messages|
|0x0004	|Log informational and success events|
|0x0005	|Log informational, success events and error messages|
|0x0006	|Log informational, success events and warnings|
|0x0007	|Log informational, success events, warnings, and error messages (all log levels)|

Its recommended that you set it to just 4

## Powershell Script

```powershell
$UNCPath = "[YOUR-CUSTOM-PATH]"
$UNCPathTest = Test-path $UNCPath

if($UNCPathTest -eq "True"){

    $TLSEvents = $Null
    $TLSReport = $Null
    $RegPath = 'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL'
    $LogValue = (Get-ItemProperty -Path $RegPath).EventLogging
    $TLSEvents = Get-EventLog -LogName System -InstanceId 36880


    if ($LogValue -eq 4 -and $TLSEvents.count -gt 0){
    $Computername = hostname
    $TimeOfLog = get-date -format yyyy-MM-dd
    $CSVShare = "$UNCPath\$TimeOfLog-$Computername-TLS-LOGS.CSV"


    $TLSReport = [System.Collections.Generic.List[Object]]::new()

    foreach ($event in $TLSEvents){
        $ReportLine = [PSCustomObject] @{
        Time         = $event.timegenerated
        MachineName  = $Computername
        Type         = $event.replacementstrings[0]
        TLSVersion   = $event.replacementstrings[1]
        CipherSuite  = $event.replacementstrings[2]
        Resource     = $event.replacementstrings[5]
        Certificate  = $event.replacementstrings[7]
    }

    $TLSReport.Add($ReportLine)
    }

    $TLSReport|Export-Csv -NoTypeInformation -path $CSVShare

    }else{
        write-host "Success Logs not set and/or no log entries exist, Exiting!"
    }
}else{
    write-host "Error: path not found!"
}
```
Move files in nested directories to one location

```powershell
get-childitem -Recurse *.csv|?{Move-Item -Path $_.fullname -Destination .\All\}
```

If you have a lot of CSV files do this to combine them all

```powershell
$CSV = Get-ChildItem *.csv
$File = read-host -prompt "Path to save files to?"
foreach ($File in $CSV) {
    import-csv $File.name|Export-Csv -Path $File -Append -NoTypeInformation
}
```
