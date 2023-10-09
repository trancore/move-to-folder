Set-PSDebug -strict

# 移動したいファイルが入ったディレクトリ
$directoryToBeMoved = ""
# ファイルの区切り文字
$delimiter = ""
# 保管ディレクトリパス（＝カレントディレクトリ）
$databaseDirectoryPath = $PSScriptRoot
# 移動したいファイルが入ったディレクトリパス
$directoryPathToBeMoved = Join-Path $databaseDirectoryPath $directoryToBeMoved

Set-Location $databaseDirectoryPath

$fileNameListToBeMoved = Get-ChildItem -Path $directoryPathToBeMoved -Name -File
$databaseDirectoryNameList = Get-ChildItem -Path $databaseDirectoryPath -Name -Directory

foreach ($fileName in $fileNameListToBeMoved) {
    $fileNameNotHasDelimiter = $fileName.Split($delimiter)[0]
    $matchedFileName = $databaseDirectoryNameList | Where-Object { $_ -eq $fileNameNotHasDelimiter }
    if ($matchedFileName) {
        Move-Item (Join-Path $directoryPathToBeMoved $fileName) (Join-Path $databaseDirectoryPath $matchedFileName)
        Write-Host "👍 ${$filename} → ${$matchedFileName}"
    }    
}

Set-PSDebug -Off