# Morse Code Powershell Script

```powershell
function dot{
[console]::beep(1000, 250)
}

function dash{
[console]::beep(3000, 500)
}

function space{
[console]::beep(1000, 1500)
}


#The following should only contain ".","-", or "/"
$Word = read-host "Morse Code"
$word = $word.trim()

$i = 0
while ($i -le $word.length){
    switch ($word[$i]){
    ([char]0x02E) {dot}
    ([char]0x02D) {dash}
    ([char]0x02f) {space}
    default {}
    }
$i++
}
```
