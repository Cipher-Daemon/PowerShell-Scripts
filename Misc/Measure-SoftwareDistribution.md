## While Loop

```powershell
while ($true){
cls
$a = (Get-ChildItem -Recurse c:\windows\softwaredistribution|Measure-Object -sum length).sum
'{0:N0}' -f $a
(get-date).datetime
start-sleep -seconds 10
}
```

## One Liner One Time

```powershell
$a = (Get-ChildItem -Recurse c:\windows\softwaredistribution -ErrorAction SilentlyContinue|Measure-Object -sum length).sum;'{0:N0}' -f $a
```
