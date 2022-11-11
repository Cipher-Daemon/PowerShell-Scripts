$X = read-host -prompt "Base64"; [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("$X"))
