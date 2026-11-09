```powershell
## Source - https://superuser.com/a/1817805
## Posted by JamesThomasMoon
## Retrieved 2026-11-05, License - CC BY-SA 4.0

function Print-ProcessTree() {

    function Get-ProcessAndChildProcesses($Level, $Process) {
        "{0}[{1,-5}] [{2}]`n{0}  Path: {3}`n{0}  Cmd : {4}" -f ("  " * $Level), $Process.ProcessId, $Process.Name, $Process.ExecutablePath, $Process.CommandLine
        $Children = $AllProcesses | where-object {$_.ParentProcessId -eq $Process.ProcessId -and $_.CreationDate -ge $Process.CreationDate}
        if ($null -ne $Children) {
            foreach ($Child in $Children) {
                Get-ProcessAndChildProcesses ($Level + 1) $Child
            }
        }
    }

    $AllProcesses = Get-CimInstance -ClassName "win32_process"
    $RootProcesses = @()
    # Process "System Idle Process" is processed differently, as ProcessId and ParentProcessId are 0
    # $AllProcesses is sliced from index 1 to the end of the array
    foreach ($Process in $AllProcesses[1..($AllProcesses.length-1)]) {
        $Parent = $AllProcesses | where-object {$_.ProcessId -eq $Process.ParentProcessId -and $_.CreationDate -lt $Process.CreationDate}
        if ($null -eq $Parent) {
            $RootProcesses += $Process
        }
    }
    # Process the "System Idle process" separately
    "[{0,-5}] [{1}]`n  Path: {2}`n  Cmd : {3}" -f $AllProcesses[0].ProcessId, $AllProcesses[0].Name, $AllProcesses[0].ExecutablePath,$AllProcesses[0].CommandLine
    foreach ($Process in $RootProcesses) {
        Get-ProcessAndChildProcesses 0 $Process
    }
}


```

# JSON PRETTY

```powershell
# Retrieve processes with parent IDs using CIM
$procs = Get-CimInstance -ClassName Win32_Process | Select-Object ProcessId, ParentProcessId, Name, ExecutablePath,commandline

# Build a lookup hash table
$processMap = @{}
$rootProcesses = [System.Collections.Generic.List[object]]::new()

foreach ($p in $procs) {
    $processMap[$p.ProcessId] = [pscustomobject]@{
        Id         = $p.ProcessId
        ParentId   = $p.ParentProcessId
        Name       = $p.Name
        Path       = $p.ExecutablePath
        CommandLine = $p.CommandLine
        Children   = [System.Collections.Generic.List[object]]::new()
    }
}

# Assemble the tree
foreach ($p in $processMap.Values) {
    if ($p.ParentId -and $processMap.ContainsKey($p.ParentId)) {
        $processMap[$p.ParentId].Children.Add($p)
    } else {
        $rootProcesses.Add($p)
    }
}

# Convert the tree structure to JSON
$jsonOutput = $rootProcesses | ConvertTo-Json -Depth 10
$jsonOutput | Out-File -FilePath "C:\users\administrator\desktop\process-tree.json" -Encoding utf8
Write-Output $jsonOutput

```
