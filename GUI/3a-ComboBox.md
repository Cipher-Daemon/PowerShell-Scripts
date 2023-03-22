# Dropdown/Combobox

```powershell
add-type -AssemblyName system.windows.forms

$formObject=[System.Windows.Forms.Form]
$LabelObject=[System.Windows.Forms.Label]
$ComboBoxObject=[System.Windows.Forms.ComboBox]

$DefaultFont='calbri,15'

#Form box creation
$appform=new-object $formObject
$appform.ClientSize='500,300'
$appform.Text='Services List'
$appform.BackColor='#ffffff'
$appform.Font=$DefaultFont

#Making form
$labelservice=new-object $LabelObject
$labelservice.Text='Service:'
$labelservice.AutoSize=$true
$labelservice.Location=new-object System.Drawing.Point(20,20)

#Making a combobox/dropdown box
$DropDownListService=new-object $ComboBoxObject
$DropDownListService.Width='300'
$DropDownListService.Location=New-Object System.Drawing.Point(150,20)

Get-Service|ForEach-Object{$DropDownListService.Items.Add($_.name)} #Adding the services names to the dropdown

<#
Alternatively you can also use:

$services = Get-Service

foreach ($service in $Services){
    $DropDownListService.items.add($service.name)
}
#>

$DropDownListService.Text='Select a service' #This adds text in the dropdown, by default its blank

$appform.Controls.AddRange(@($labelservice,$DropDownListService))

#Display Form
$appform.ShowDialog()

#Garbage collection
$appform.Dispose()
```
