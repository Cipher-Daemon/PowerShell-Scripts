#To filter only workstations
```powershell
Get-ADComputer -Filter  {OperatingSystem -notLike '*SERVER*' } -Properties lastlogondate,operatingsystem |select name,lastlogondate,operatingsystem|sort -descending lastlogondate
```

To filter by DN

```powershell
Get-ADComputer -Filter * -searchbase "[Distinguished Name]" -Properties lastlogondate,operatingsystem |select name,lastlogondate,operatingsystem|sort -descending lastlogondate
```
