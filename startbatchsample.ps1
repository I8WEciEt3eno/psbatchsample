$ErrorActionPreference = "Stop"
. ".\commonsample.ps1"
$batchname  = $Args[0]
$batchparam = $Args[1]
try {
  $logfile    = getLogfile $batchname
  $scriptfile = Join-Path -Path $PSScriptRoot -ChildPath ($batchname + ".ps1")
  & $scriptfile $logfile $batchparam
}
catch {
  errorLog $logfile "error occurred." "startbatchsample"
  errorLog $logfile $Error[0].Exception.Message "startbatchsample"
}