# Adding Function With Buttons

Most of the code is from the first file but this adds a button function to make "Hello World" appear and disappear

```powershell
#Making Hello World

add-type -AssemblyName system.windows.forms



$FormObject = [System.Windows.Forms.Form] #Form is the dialog box
$Labelobject = [System.Windows.Forms.Label] #Labels are Text in the Window
$ButtonObject = [System.Windows.Forms.Button]


$HelloWorldForm = new-object $FormObject #Create new form
$HelloWorldForm.ClientSize='500,300' #size of form box
$HelloWorldForm.Text='Hello World' #Title of form box
$HelloWorldForm.BackColor="#ffffff" #Background Color

$LabelTitle= New-Object $Labelobject #Makes new label object
$LabelTitle.Text='Hello World' #Text in the dilog box
$LabelTitle.AutoSize=$True #Autosize true or false
$LabelTitle.Font='Calbri,24,style=bold' #Format is Font,Size,style=[bold,italic,etc]
$LabelTitle.Location=new-object System.Drawing.Point(120,60) # X & Y Position inside the dialog box



#########################################
#Adding buttons
$ButtonHello = New-Object $ButtonObject
$ButtonHello.Text='Say Hello'
$ButtonHello.AutoSize=$True
$ButtonHello.font='calbri,14'
$ButtonHello.Location=new-object System.Drawing.Point(185,180)

$HelloWorldForm.Controls.Addrange(@($LabelTitle,$ButtonHello))


#Function
function sayhello{
    if($LabelTitle.Text -eq ''){
        $LabelTitle.Text='Hello world'
        }else{
            $LabelTitle.text=''
        }
}

#adding function
$ButtonHello.add_click({sayhello})



#To display
$HelloWorldForm.ShowDialog()

#This cleans the form
$HelloWorldForm.Dispose()
```
