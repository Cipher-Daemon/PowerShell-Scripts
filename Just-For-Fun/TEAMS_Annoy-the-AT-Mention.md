How to annoy the living nerves of your coworkers, replace/add the letters to your coworkers name.

```powershell
start-sleep -Seconds 5
Add-Type -AssemblyName System.Windows.Forms
[int]$MilliSeconds = 250 #250 seems to be the magic number, dont do less than 100.
for ($i=0;$i -le 8;$i++){

[System.Windows.Forms.SendKeys]::SendWait('@')
Start-Sleep -Milliseconds $MilliSeconds
[System.Windows.Forms.SendKeys]::SendWait('r')
Start-Sleep -Milliseconds $MilliSeconds
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds $MilliSeconds
write-host -ForegroundColor Red $i
}
```
## Other functions

Control V (Paste) - `[System.Windows.Forms.SendKeys]::SendWait('^v')`


## Automatically Focus Based On Input Of Window Title Name

```powershell

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll")]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
}
"@


$Win32API = Add-Type -Name Funcs -Namespace Win32 -PassThru -MemberDefinition @'
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
'@

Start-Sleep -Seconds 1
Add-Type -AssemblyName System.Windows.Forms


$windowTitle = read-host "App Window Name? (Must be the EXACT Title Name!)"   # EXACT title
$hWnd = $Win32API::FindWindow([NullString]::Value, $windowTitle)

[int]$MaxLoops = read-host "How many times you want to loop this?"

if ($hWnd -ne [IntPtr]::Zero) {
    [WinAPI]::SetForegroundWindow($hWnd)
    Start-Sleep -Milliseconds 500

    for ($i=1; $i -le $MaxLoops; $i++) {
        [System.Windows.Forms.SendKeys]::SendWait('@')
        Start-Sleep -Milliseconds 100
        [System.Windows.Forms.SendKeys]::SendWait('t')
        Start-Sleep -Milliseconds 100
        [System.Windows.Forms.SendKeys]::SendWait('{ENTER}{ENTER}')
        Write-Host -ForegroundColor Red $i
    }
} else {
    Write-Host "Window not found!"
}

```
