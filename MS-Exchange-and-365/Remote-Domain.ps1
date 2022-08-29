# to make a new remote domain policy

New-RemoteDomain -DomainName *.contoso.com -Name Contoso

# to disable auto forwarding to the default

Set-RemoteDomain Default -AutoForwardEnabled $false
