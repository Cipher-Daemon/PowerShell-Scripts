# Second part of the ComboBox

```powershell
add-type -AssemblyName system.windows.forms

$formObject=[System.Windows.Forms.Form]
$LabelObject=[System.Windows.Forms.Label]
$ComboBoxObject=[System.Windows.Forms.ComboBox]

$DefaultFont='calbri,12'

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

#This shows the "Service Friendly Name"
$labelForServiceName=new-object $LabelObject
$labelForServiceName.Text='Service Friendly Name:'
$labelForServiceName.AutoSize=$true
$labelForServiceName.Location=new-object System.Drawing.Point(20,80)

#This shows the text to the right of "Service Friendly Name"
$labelserviceName=new-object $LabelObject
$labelserviceName.Text='' #add a test text to make sure its showing
$labelserviceName.AutoSize=$true
$labelserviceName.Location=new-object System.Drawing.Point(280,80)

#This shows the "Status:"
$labelForStatus=new-object $LabelObject
$labelForStatus.Text='Status:'
$labelForStatus.AutoSize=$true
$labelForStatus.Location=new-object System.Drawing.Point(20,120)

#This shows the text to the right of "Status:"
$labelstatus=new-object $LabelObject
$labelstatus.Text='' #add a test text to make sure its showing
$labelstatus.AutoSize=$true
$labelstatus.Location=new-object System.Drawing.Point(280,120)

$appform.Controls.AddRange(@($labelservice,$DropDownListService,$labelForServiceName,$labelserviceName,$labelForStatus,$labelstatus)) #Need to add all the variables that you want to render in the dialog box


#Adding Functions

function GetServiceDetail{
    $ServiceName=$DropDownListService.SelectedItem
    $details=get-service -name $servicename| select *
    $labelserviceName.text=$details.displayname #This changes the text in the labelservicename text
    $labelstatus.text=$details.status #This changes the text in the status text


    #changing the color based on text
    if($labelstatus.text -eq 'Running'){
        $labelstatus.ForeColor='green'
    }else{
        $labelstatus.ForeColor='red'
    }
}

#Add function to control

$DropDownListService.add_selectedindexchanged({getservicedetail})


#Display Form
$appform.ShowDialog()

#Garbage collection
$appform.Dispose()
```
