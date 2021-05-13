#requires -Version 3.0
#requires -RunAsAdministrator

# Путь до скрипта для задания планировщика
$path = "C:\Test\task2.ps1"
# Имя пользователя, от которого будет добавлено задание
$user = "NT AUTHORITY\SYSTEM"

$trigger = New-ScheduledTaskTrigger -At 02:00am -Daily
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $path"

Register-ScheduledTask -TaskName "Task2_Backup" -Trigger $trigger -User $user -Action $action -RunLevel Highest -Force
