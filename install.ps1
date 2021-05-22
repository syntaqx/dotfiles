# Windows 10 Provisioning Script
# PowerShell, be sure to run: Set-ExecutionPolicy RemoteSigned -scope CurrentUser
# Bypass is also a good setting.

# Script parent directory source.
# $PSScriptRoot

# Self elevate administrative permissions in this script
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs;
  exit
}

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
  Write-Host "Enabling OpenSSH from Windows..." -ForegroundColor Green
  Add-WindowsCapability -Name $openSsh.Name -Online
}

Set-Service ssh-agent -StartupType Automatic

$sshAgentStopped = 'Stopped' -eq (Get-Service -Name 'ssh-agent' -ErrorAction SilentlyContinue).status
Write-Verbose -Message ('SSH Agent Status is stopped: {0}' -f $sshAgentStopped)
if ($sshAgentStopped) {
  Write-Verbose -Message 'Starting SSH Agent for this session...'
  Start-Service -Name 'ssh-agent'
}

# NOTE: Was really loud, but it's pretty helpful.
# Get-Service ssh-agent

# -----------------------------------------------------------------------------
# Configure Windows Firewall for common local development ports
Write-Host ""
Write-Host "Configuring Firewall for Development..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

[void](New-NetFirewallRule -DisplayName '.dotfiles ~/ SSH' -Profile @('Private','Domain') -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22)
Write-Host 'Allowing SSH...'

[void](New-NetFirewallRule -DisplayName '.dotfiles ~/ HTTP(s)' -Profile @('Private','Domain') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(80,81,443))
Write-Host 'Allowing HTTP(s)...'

[void](New-NetFirewallRule -DisplayName '.dotfiles ~/ Local Development' -Direction Inbound -Action Allow -Protocol TCP -LocalPort @(1337,3000,3001,8080,8081,"9000-9100","9200-9400","9900-9999"))
Write-Host 'Allowing commong in-development ports...'

[void](Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen True -AllowUnicastResponseToMulticast True)
Write-Host 'Enabled and configured Windows Firewall...'

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Installing applications [winget]..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

$wingetApplications = @(
  "Microsoft.PowerToys",
  "Microsoft.WindowsTerminal",
  "Amazon.AWSCLI"
)

if (Check-Command -cmdname 'winget') {
  foreach ($query in $wingetApplications) {
    winget install -e --id $query
  }
} else {
  Write-Host "winget not installed, skipping..." -ForegroundColor Red
}

# ------------------------------------------------------------------------------
# Install scoop and some apps
Write-Host ""
Write-Host "Installing scoop package manager..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

if (Check-Command -cmdname 'scoop') {
  Write-Host "scoop is already installed, skipping." -ForegroundColor Gray
} else {
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# -----------------------------------------------------------------------------
# Install packages: scoop
Write-Host ""
Write-Host "Installing applications [scoop]..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

scoop bucket add extras

scoop install sudo coreutils cacert 7zip curl wget
scoop install pandoc gh act terraform

scoop install extras/vcredist2019
scoop install php composer

# php-xdebug already included

# -----------------------------------------------------------------------------
# Ensure configuration and source directories exist for later
Write-Host ""
Write-Host "Setting up development user directories..." -ForegroundColor Green

(".ssh",".config",".local","bin","Projects","Workspaces") |foreach {
  mkdir -p $env:USERPROFILE/$_ -Force | Out-Null;
}

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
# Write-Host "------------------------------------" -ForegroundColor Green
# Read-Host -Prompt "Setup complete, restart is needed. Press [ENTER] to restart computer."
# Restart-Computer
