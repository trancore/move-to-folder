Set-PSDebug -strict
Set-Location $databaseDirectoryPath

# 移動したいファイルが入ったディレクトリ
$directoryToBeMoved = "/want-to-move-file-list"
# ファイルの区切り文字
$delimiter = " 第"
# 保管ディレクトリパス（＝カレントディレクトリ）
$databaseDirectoryPath = $PSScriptRoot
# 移動したいファイルが入ったディレクトリパス
$directoryPathToBeMoved = Join-Path $databaseDirectoryPath $directoryToBeMoved
# ログファイルのファイルパス
$logFilePath = Join-Path $PSScriptRoot "/log.txt"

Start-Transcript $logFilePath -Append

$fileNameListToBeMoved = Get-ChildItem -Path $directoryPathToBeMoved -Name -File
$databaseDirectoryNameList = Get-ChildItem -Path $databaseDirectoryPath -Name -Directory

foreach ($fileName in $fileNameListToBeMoved) {
    $fileNameNotHasDelimiter = $fileName.Split($delimiter)[0]
    $matchedFileName = $databaseDirectoryNameList | Where-Object { $_ -eq $fileNameNotHasDelimiter }

    if ($matchedFileName) {
        try {
            Move-Item (Join-Path $directoryPathToBeMoved $fileName) (Join-Path $databaseDirectoryPath $matchedFileName)
            Write-Host "【${Get-Date}】：【INFO】 ${$filename} → ${$matchedFileName}" 
        }
        catch {
            Write-Error "【${Get-Date}】：【ERROR】 ${$_.Exception.Message}"
        }
        
    }    
}

Stop-Transcript
Set-PSDebug -Off