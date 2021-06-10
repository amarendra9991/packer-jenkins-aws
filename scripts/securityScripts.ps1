#Script to clean Spectre and IE11 FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX
$servers = $env:COMPUTERNAME
foreach($server in $servers)
{
    Write-Host "Checking: MeltDown/Spectre Post Registry setting on " $server"...." -ForegroundColor Yellow
    $objReg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $server)
     
    $objRegKeyPM = $objReg.OpenSubKey("SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management",$true)
    if ($objRegKeyPM) 
    {
        Write-Host "Updating: MeltDown/Spectre Post Registry setting on " $server", proceeding with configuration..."  -ForegroundColor Green
        $devnull = $objRegKeyPM.Close

        $objRegKeyPM = $objReg.CreateSubKey("SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management")
        $objRegKeyPM.SetValue("FeatureSettingsOverride", 72)

        $objRegKeyPM = $objReg.CreateSubKey("SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management")
        $objRegKeyPM.SetValue("FeatureSettingsOverrideMask", 3)

    }
    $devnull = $objRegKeyPM.Close
}

foreach($server in $servers)
{
    Write-Host "Checking: June KB4022722 Vulnerability on " $server"...." -ForegroundColor Yellow
    $objReg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $server)
     
    $objRegKeyPM = $objReg.OpenSubKey("SOFTWARE\\Microsoft\\Internet Explorer\\MAIN\\FeatureControl\\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX",$true)
    if (!$objRegKeyPM) 
    {
        Write-Host "Updating: June KB4022722 Vulnerability on " $server", proceeding with configuration..."  -ForegroundColor Green
        $devnull = $objRegKeyPM.Close
       
        $objRegKeyPM = $objReg.CreateSubKey("SOFTWARE\\Microsoft\\Internet Explorer\\MAIN\\FeatureControl\\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX")
        $objRegKeyPM.SetValue("iexplore.exe", 1)

        $objRegKeyPM = $objReg.CreateSubKey("SOFTWARE\\Wow6432Node\\Microsoft\\Internet Explorer\\MAIN\\FeatureControl\\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX")
        $objRegKeyPM.SetValue("iexplore.exe", 1)

    }
    $devnull = $objRegKeyPM.Close
}         