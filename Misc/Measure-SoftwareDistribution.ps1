while ($true){
$a = (Get-ChildItem -Recurse c:\windows\softwaredistribution|Measure-Object -sum length).sum
'{0:N0}' -f $a
start-sleep -seconds 10
(get-date).datetime
}
