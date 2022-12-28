# Merge two mailboxes

## Get GUID for the two mailboxes

To get the GUID of a mailbox
```
get-mailbox -idendity [displayname]|select Name, GUID
```

To get the GUID of a softdelete mailbox

```
get-mailbox -SoftDeletedMailbox -Identity [Displayname]|Select name, GUID
```

## Merge the mailboxes

```
New-MailboxRestoreRequest -SourceMailbox [GUID of Source Mailbox] -TargetMailbox [GUID of Destination Mailbox] -AllowLegacyDNMismatch
```

## Status of the merge request

Get the Mailbox Request GUID

```
Get-MailboxRestoreRequest |select Name,Targetmailbox,Status,Requestguid
```

Do a loop to show status every X seconds

```
while($True){
  Get-MailboxRestoreRequestStatistics -identity [Request GUID]|Select Name,StatusDetail,TargetAlias,PercentComplete
  start-sleep [number of seconds]
  }
```
