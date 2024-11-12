. ".\commonsample.ps1"
try {
  $logfile = $Args[0]
  $batchname = "batchA"
  startLog $logfile $batchname
  $settingxml = [xml](Get-Content ".\batchAsettingsample.xml")
  $targetdirectory = $settingxml.batchasettings.targetdirectory
  $targetfilename = $settingxml.batchasettings.targetfilename
  $keepfilecount = $Args[1]
  infoLog $logfile ("keepfilecount=" + $Args[1]) $batchname
  for ($i=0; $i -lt 10001; $i++) {
    $s = "{0:00000}" -f $i
    $p = Join-Path -Path $targetdirectory -ChildPath ($s + ".txt")
    $i > $p
    infoLog $logfile ("create file " + $p) $batchname
  }
  while ($true) {
    $files = Get-ChildItem -Path $targetdirectory -Filter $targetfilename | Sort-Object -Property LastWriteTime, Name
    infoLog $logfile $files.Count $batchname
    if ($files.Count -le $keepfilecount) {
      break
    } else {
      $deletetarget = $files | Select-Object -First 1
      infoLog $logfile $deletetarget $batchname
      Remove-Item -Path (Join-Path -Path $targetdirectory -ChildPath $deletetarget)
    }
  }

  endLog $logfile $batchname
}
catch {
  errorLog $logfile "error occurred." "batchA"
  errorLog $logfile $Error[0].Exception.Message "batchA"
  throw
}