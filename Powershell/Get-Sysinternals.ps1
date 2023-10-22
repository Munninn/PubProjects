<#
.SYNOPSIS 
    Function Get-Sysinternals downloads Sysinternals Suite to a local folder.
.DESCRIPTION 
    Get-Sysinternals will
      - download the SysinternalsSuite.zip
      - unblock it
      - and decompress it to c:\sysinternals
    Check the Parameter Section for your desired paths!
    Using the .NET Class System.Net.WebClient for faster download.
    If you prefer Invoke-Webrequest - it's already there, just uncomment it. Then you can get rid of Write-Host because iwr shows progress.
.EXAMPLE
    Execute .ps1 directly from Shell with dot sourcing
    . .\Get-Sysinternals
    Then simply run the cmdlet Get-Sysinternals
.NOTES 
    Author: Oliver Jäkel | oj@jaekel-edv.de | @JaekelEDV
#>
Function Get-Sysinternals {
  [CmdletBinding()]
  param ()
    [string] $temp = "$env:HOMEDRIVE\temp\"
    [string] $url = 'http://download.sysinternals.com/files/SysinternalsSuite.zip'
    [string] $downloadpath = "$temp\SysinternalsSuite.zip"
    [string] $destination = "$env:HOMEDRIVE\SYSINTERNALS\"
    
  if (!(Test-Path -Path $temp))
  {New-Item -Path $env:HOMEDRIVE\temp -ItemType Directory -Verbose | Out-Null
  }
  else {Write-Host 'Good - c:\temp already exists...' -ForegroundColor Yellow}
  
  Write-Host 'Downloading SysinternalsSuite.zip' -ForegroundColor Yellow
  
  (New-Object System.Net.WebClient).DownloadFile($url,$downloadpath)
    
  #Invoke-WebRequest -Uri $url -OutFile $downloadpath

  Write-Verbose -Message "Downloading SysinternalsSuite.zip to $temp"
  
  $file = Get-Item -Path "$env:HOMEDRIVE\temp\SysinternalsSuite.zip"
  Unblock-File -Path $file -Verbose

  if (!(Test-Path -Path $destination))
  
  {New-Item -ItemType Directory -Force -Path "$destination" -Verbose | Out-Null
  }
  Expand-Archive -Path $file -DestinationPath $destination -Force
  
  Set-Location -Path $destination
}