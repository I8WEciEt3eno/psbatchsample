. ".\commonsample.ps1"
try {
  $logfile = $Args[0]
  startLog $logfile "testsample"
  infoLog $logfile $Args[1] "testsample"
  endLog $logfile "testsample"
}
catch {
  errorLog "error occurred." "testsample"
  errorLog $Error[0].Exception.Message "testsample"
  throw
}