function getLogfile($batchname) {
    $settingxml = [xml](Get-Content ".\commonsettingsample.xml")
    $logfilename = $batchname + "_" + (Get-Date -Format "yyyyMMddHHmmss") + ".log"
    $logdirectory = $settingxml.scsettings.logdirectory
    $logfile = Join-Path -Path $logdirectory -ChildPath $logfilename
    return $logfile
}

function log($logfile, $message, $level) {
    $now = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Output "[$now] [$level] $message" | Out-File -Append -FilePath $logfile -Encoding UTF8
}

function infoLog($logfile, $message) {
    log $logfile $message "INFO "
}

function errorLog($logfile, $message) {
    log $logfile $message "ERROR"
}

function startLog($logfile) {
    infoLog $logfile "batch start."
}

function endLog($logfile) {
    infoLog $logfile "batch end."
}