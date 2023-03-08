# Create HTML tables for report

## Header Code

```powershell
$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@
```

## Command Syntax with $Header

``` Powershell
[some command for reporting]|convertto-html -head $Header|out-file -path c:\path\to\file.html
```
