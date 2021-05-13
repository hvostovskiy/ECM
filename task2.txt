
# Полный путь до лог-файла
$src_path = "C:\log.txt"
# Каталог для резервного копирования
$dst_path = "D:\Backup"
# Время хранения копий (дней)
$max_days = 7

if (!(Test-Path $dst_path -PathType Container)) {
	New-Item -ItemType Directory -Force -Path $dst_path
}

Get-ChildItem -Path $dst_path -Force `
| Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt (Get-Date).AddDays(-$max_days) } `
| Remove-Item -Force

$bak_file = "$(Get-Date -Format 'yyyy-MM-dd')_$(Split-Path $src_path -Leaf)"
Copy-Item -Path $src_path -Destination $dst_path\$bak_file -Force
