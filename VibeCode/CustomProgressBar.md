```powershell
$Items = (1..100)
$Total = $Items.Count
$Current = 0

foreach ($Item in $Items) {
    $Current++

    $Percent = $Current / $Total
    $BarLength = 30
    $Filled = [math]::Floor($Percent * $BarLength)

    $Bar = ('#' * $Filled).PadRight($BarLength, '-')

    Write-Host  "`r[$Bar] $([math]::Round($Percent * 100,0))%"

# work here
    Start-Sleep -Milliseconds 500
}

Write-Host "`n"

```
