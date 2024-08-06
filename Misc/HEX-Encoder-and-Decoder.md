# HEX Encoder & Decoder
### Some is WIP

## To HEX

```powershell
$TEX_HEX = $NULL
$MYTEXT= read-host "Text?"
$MYCHAR_ARRAY=$MYTEXT.ToCharArray()
Foreach ($CHAR in $MYCHAR_ARRAY) {
$TEX_HEX = $TEX_HEX + ' ' + [System.String]::Format("{0:X2}", [System.Convert]::ToUInt32($CHAR))
}
$TEX_HEX -replace " ",""|clip
```

## From HEX

```powershell
$MYHEX=$TEX_HEX
$MYHEX_ARRAY=$MYHEX.Split("")
Foreach ($HEX in $MYHEX_ARRAY) {
$MYTEXT= $MYTEXT +  [char]([convert]::toint16($HEX,16))
}
$MYTEXT
```
