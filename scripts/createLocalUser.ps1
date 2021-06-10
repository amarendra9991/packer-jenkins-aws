Write-Host "Creating Local User on " $server"...."
$Password = ConvertTo-SecureString "Emirates1" -AsPlainText -Force
New-LocalUser "demo-user" -password $Password
Add-LocalGroupMember -Group "Administrators" -Member "demo-user"