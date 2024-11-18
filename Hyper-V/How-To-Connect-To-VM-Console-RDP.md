# How to connect to a Hyper-V VM Console via RDP

1. Get the VM ID:

```powershell
get-vm -name <VM-NAME> | select id
```

2. create a .rdp file that points to the Hyper-V host
3. Assuming that the Hyper-v host IP address is `10.10.10.10` and the VM GUID is `12345678-abcd-1234-abcd-123456789012` append the information at the end of the .rdp file created from earlier

Note: hostnames will also work for the `full address` field.
```
full address:s:10.10.10.10
pcb:s:12345678-abcd-1234-abcd-123456789012
server port:i:2179
negotiate security layer:i:0
```

4. Save the edited .rdp file and connect ot the VM (Note: the VM has to be running for it to work. Otherwise you'll get a connection error)
