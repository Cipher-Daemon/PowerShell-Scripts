# Brain Dump

```powershell
#Text Box

$ServiceListBox = new-object $TextBoxObject
$serviceListBox.Multiline = $True
$ServiceListBox.Location = New-Object System.Drawing.Size(20,160)
$serviceListBox.Size = New-Object System.Drawing.Size(200,75)
$ServiceListBox.ScrollBars = "both"
$ServiceListBox.ReadOnly = $false
$ServiceListBox.WordWrap = $False


$ServiceListBox.BackColor = '#000000'
$ServiceListBox.ForeColor = '#FFFFFF'

#$ServiceListBox.AppendText(

Get-Service|ForEach-Object{$DropDownListService.Items.Add($_.name)} #Adding the services names to the dropdown
#Get-Service|ForEach-Object{$ServiceListBox.appendtext($_.name)}
$A = (Get-service).Name
$B = $A -join "`r`n"
$ServiceListBox.AppendText($b)
```
