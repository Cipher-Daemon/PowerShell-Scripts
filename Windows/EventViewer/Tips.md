# Tips

## Time span via XML Path

To filter past 15 minutes (Note below for the timediff is in milliseconds)

```powershell
Get-WinEvent -LogName Security -FilterXPath "*[System[EventID=4688 and TimeCreated[timediff(@SystemTime) <= 900000]]]"
```
