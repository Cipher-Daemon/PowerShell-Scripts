# Form Dot Notation

## Form value:

```powershell
$Window.[System.Windows.Forms.Form]
```

### To remove the Minimize, Maximize and Close Button

```powershell
$Window.MaximizeBox = $False
$Window.MinimizeBox = $False
$Window.ControlBox = $False
```

### To not make the window adjustable

```powershell
$Window.FormBorderStyle = 'Fixed3D'
```
### To show the function the same time the window is shown

What this means is that say you have a function you want to show the same time the form is shown (eg. flashing text) use the follwoing to do so:

We'll assume that the Function you created is called "FlashingText"
```powershell
$Window.add_Shown({FlashingText})
$Window.ShowDialog()
```

Note: if you have a function that never ends (like a while($True) loop) it will not be possible to close the window without forcing it to quit via taskmanager.
