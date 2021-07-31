$watcher = New-Object System.IO.FileSystemWatcher
$watcher.IncludeSubdirectories = $true
$watcher.Path = 'C:\Users\nelsons\Documents\GitHub\testConnect\.git'
$watcher.Filter = 'ORIG_HEAD*.*'
$watcher.EnableRaisingEvents = $true
$destination = '\\dorsp19.fdor.dor.state.fl.us@SSL\DavWWWRoot\sites\gta\SiteAssets\devCode\pageTemplates\testConnect'
$action =
{
    $path = 'C:\Users\nelsons\Documents\GitHub\testConnect'
    # $changetype = $event.SourceEventArgs.ChangeType
    Write-Host "$path was REFRESHED at $(get-date)"
    robocopy $path $destination /e /xo /xd .git /xf .gitattributes
    $wshell = New-Object -ComObject wscript.shell
    if ($wshell.AppActivate('Chrome')) {
        # Switch to Chrome
        Start-Sleep 1 # Wait for Chrome to "activate"
        $wshell.SendKeys("^R")  # Send CTRL + R (Refresh)
    }
}
Register-ObjectEvent $watcher 'Created' -Action $action