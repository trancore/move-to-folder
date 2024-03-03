Set-PSDebug -strict

# 保管ディレクトリパス（＝カレントディレクトリ）
$databaseDirectoryPath = $PSScriptRoot
Set-Location $databaseDirectoryPath

# 移動したいファイルが入ったディレクトリ
$directoryToBeMoved = ""
# ファイルの区切り文字
$delimiter = ""
# 移動したいファイルが入ったディレクトリパス
$directoryPathToBeMoved = Join-Path $databaseDirectoryPath $directoryToBeMoved
# ログファイルのファイルパス
$logFilePath = Join-Path $PSScriptRoot "/log.txt"

Start-Transcript $logFilePath -Append

$fileNameListToBeMoved = Get-ChildItem -Path $directoryPathToBeMoved -Name -File
$databaseDirectoryNameList = Get-ChildItem -Path $databaseDirectoryPath -Name -Directory

foreach ($fileName in $fileNameListToBeMoved) {
    $fileNameHasDelimiterList = $fileName.Split($delimiter)
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
    elseif ($fileNameHasDelimiterList.Length -gt 1) {
        try {
            New-Item (Join-Path $databaseDirectoryPath $fileNameNotHasDelimiter) -ItemType Directory
            Move-Item (Join-Path $directoryPathToBeMoved $fileName) (Join-Path $databaseDirectoryPath $fileNameNotHasDelimiter)
        }
        catch {
            Write-Error "【${Get-Date}】：【ERROR】 ${$_.Exception.Message}"
        }
    }    

}

Stop-Transcript
Set-PSDebug -Off