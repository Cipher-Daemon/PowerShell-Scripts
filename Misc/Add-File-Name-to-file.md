- [ ] Need to add filter to just txt files
- [ ] (Optional) ask for file filters and default to just txt files

```powershell
$Files = get-childitem -Path "C:\Users\ToCheck"


foreach ($File in $Files){
    $Filename = $file.fullname
    $name = $file.basename

    Add-Content -Value $name -Path $Filename -NoNewline

    }
```
