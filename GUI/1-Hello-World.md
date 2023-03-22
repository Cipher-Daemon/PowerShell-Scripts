# Simple Hello World Dialog Box

```powershell
#Making Hello World

add-type -AssemblyName system.windows.forms


#Form is the dialog box
$FormObject = [System.Windows.Forms.Form]

#Labels are Text in the Window
$Labelobject = [System.Windows.Forms.Label]


$HelloWorldForm = new-object $FormObject #Create new form
$HelloWorldForm.ClientSize='500,300' #size of form box
$HelloWorldForm.Text='Hello World' #Title of form box
$HelloWorldForm.BackColor="#ffffff" #Background Color

$LabelTitle= New-Object $Labelobject #Makes new label object
$LabelTitle.Text='Hello World' #Text in the dilog box
$LabelTitle.AutoSize=$True #Autosize true or false
$LabelTitle.Font='Calbri,24,style=bold' #Format is Font,Size,style=[bold,italic,etc]
$LabelTitle.Location=new-object System.Drawing.Point(120,60) # X & Y Position inside the dialog box

$HelloWorldForm.Controls.Addrange(@($LabelTitle))


#To display
$HelloWorldForm.ShowDialog()

#This cleans the form
$HelloWorldForm.Dispose()
```
