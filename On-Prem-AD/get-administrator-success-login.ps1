get-eventlog -LogName Security|?{$_.instanceid -eq 4624 -and $_.message -like "*administrator*"}
