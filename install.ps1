# Windows 10 Provisioning Script
# This should be run in PowerShell

Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# Self elevate administrative permissions in this script
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

function Check-Command($cmdname) {
  return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# -----------------------------------------------------------------------------
# Configure Windows Firewall for common local development ports
Write-Host ""
Write-Host "Configuring Windows OpenSSH Service..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

$openSSH = Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Client*' | Select-Object Name, State
if ($openSSH.State -ne "Installed") {
    Write-Host "Enabling OpenSSH feature..." -ForegroundColor Green
    Add-WindowsCapability -Name $openSsh.Name -Online
}

Set-Service ssh-agent -StartupType Automatic

$sshAgentStopped = 'Stopped' -eq (Get-Service -Name 'ssh-agent' -ErrorAction SilentlyContinue).status
Write-Verbose -Message ('SSH Agent Status is stopped: {0}' -f $sshAgentStopped)

if ($sshAgentStopped) {
    Write-Verbose -Message 'Stating SSH Agent'
    Start-Service -Name 'ssh-agent'
}

Get-Service ssh-agent

# -----------------------------------------------------------------------------
# Configure Windows Firewall for common local development ports
Write-Host ""
Write-Host "Configuring Firewall for Development..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

New-NetFirewallRule -DisplayName 'SSH' -Profile @('Private','Domain') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(22)
New-NetFirewallRule -DisplayName 'HTTP(s)' -Profile @('Private','Domain') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(80,81,443)
New-NetFirewallRule -DisplayName 'Local Development' -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(1337,3000,3001,8080,8081,"9000-9100","9200-9400","9900-9999")

# (re)Enable the Windows Firewall with Multicast
Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen True -AllowUnicastResponseToMulticast True

# ------------------------------------------------------------------------------
# Install scoop and some apps
if (Check-Command -cmdname 'scoop') {
  Write-Host "scoop is already installed, skipping."
}
else {
  Write-Host ""
  Write-Host "Installing scoop..." -ForegroundColor Green
  Write-Host "------------------------------------" -ForegroundColor Green
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Installing applications [winget]..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

$wingetApplications = @(
  "Microsoft.PowerToys",
  "Microsoft.WindowsTerminal"
)

foreach ($query in $wingetApplications) {
  winget install -e --id $query
}

# -----------------------------------------------------------------------------
# Install packages: scoop
Write-Host ""
Write-Host "Installing applications [scoop]..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

scoop bucket add extras

scoop install extras/vcredist2019
scoop install sudo coreutils cacert 7zip curl wget
scoop install pandoc gh act

scoop install php php-xdebug composer

# -----------------------------------------------------------------------------
# Configures Git to use OpenSSH, wincred, and compatibilities with WSL2
Write-Host ""
Write-Host "Configuring Git for Windows..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

git config --global core.sshcommand "C:/Windows/System32/OpenSSH/ssh.exe"
git config --global credential.helper wincred

# ------------------------------------------------------------------------------
# Enable Virtualization and containerization functionality
Write-Host ""
Write-Host "Installing WSL..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName VirtualMachinePlatform
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

# ------------------------------------------------------------------------------
# Restart Windows
Write-Host "------------------------------------" -ForegroundColor Green
Read-Host -Prompt "Setup complete, restart is needed. Press [ENTER] to restart computer."
Restart-Computer
