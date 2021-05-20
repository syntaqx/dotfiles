# Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# TODO: Use installers directory
winget install Microsoft.Powertoys
winget install Microsoft.WindowsTerminal

# Install Tooling
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install sudo coreutils cacert 7zip curl wget
scoop install pandoc
scoop install gh

# Virtualization functionality (WSL, Hyper-V)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

echo "Checking if windows openssh client is installed"
$openSSH = Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Client*' | Select-Object Name, State

if ($openSSH.State -ne "Installed") {
    echo "Adding OpenSSH Client"
    Add-WindowsCapability -Name $openSsh.Name -Online
}

Set-Service ssh-agent -StartupType Automatic

echo "Configuring Git for use on Windows: wincred, OpenSSH Service..."

git config --global core.sshcommand "C:/Windows/System32/OpenSSH/ssh.exe"
git config --global credential.helper wincred

$sshAgentStopped = 'Stopped' -eq (Get-Service -Name 'ssh-agent' -ErrorAction SilentlyContinue).status
Write-Verbose -Message ('SSH Agent Status is stopped: {0}' -f $sshAgentStopped)

if ($sshAgentStopped) {
    Write-Verbose -Message 'Stating SSH Agent'
    Start-Service -Name 'ssh-agent'
}

Get-Service ssh-agent

# Configure Windows Firewall for common local development ports
New-NetFirewallRule -DisplayName 'SSH' -Profile @('Private','Domain') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(22)
New-NetFirewallRule -DisplayName 'HTTP(s)' -Profile @('Private','Domain') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(80,81,443)
New-NetFirewallRule -DisplayName 'Local Development' -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(1337,3000,3001,8080,8081,"9000-9100","9200-9400","9900-9999")

# (re)Enable the Windows Firewall with Multicast
Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen True -AllowUnicastResponseToMulticast True
