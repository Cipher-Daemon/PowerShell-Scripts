# One liner

```powershell
powershell.exe "Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.Speak('Hello, World!')"
```
