# Change Start Time Trigger

What this does is changing the "Start" time when you double click on one of the triggers, code below shows an example:

```powershell
$Taskname = "OneDrive Standalone Update Task-S-1-5-21-2904431338-3871400059-2466335353-500"
$task = Get-ScheduledTask -TaskName $Taskname
$trigger = $task.Triggers[0]  # Extract the first trigger
$trigger.StartBoundary = "2024-04-01T10:00:00"  # Modify
Set-ScheduledTask -TaskName $Taskname -Trigger $trigger
```

**Note:** This does work well with any task that doesnt have a password set, otherwise you must feed a password if there are password set tasks.
