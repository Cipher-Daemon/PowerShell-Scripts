Get-ADComputer -Filter  {OperatingSystem -notLike '*SERVER*' } -Properties lastlogondate,operatingsystem |select name,lastlogondate,operatingsystem|sort lastlogondate
