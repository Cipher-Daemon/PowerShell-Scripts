Create Custom Tables/CSV files

## Declare Data variable and create Row

```powershell
$Data = @()

$Row = "" | CUSTOM-HEADER-1,CUSTOM-HEADER-2,
```

## Add data to Row

```powershell
$Row.CUSTOM-HEADER-1 = $SomeData1
$Row.CUSTOM-HEADER-2 = $SomeData2
```

## Add Row Data to Data Variable

```powershell
$Data += $Row
```
