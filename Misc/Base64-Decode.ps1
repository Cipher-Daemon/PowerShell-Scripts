Function Base64-All3 {
write-host "Unicode:"; [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("$X"))
write-host " "
write-host "ASCII:"; [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("$X"))
write-host " "
write-host "UTF8:"; [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("$X"))
}

$X = read-host -prompt "Base64"

Base64-All3
