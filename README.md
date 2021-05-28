# .dotfiles ~/

Personal dotfiles, period.

> 🚧 __Extremely WIP!__ The repository is mostly functioning as functional
> notes, so it may not work as expected. Proceed at your own risk.

## Prerequisites

- Windows 10 Home/Pro Build 21390 or later
  - Windows Insider Preview (Dev Channel)
  - Windows App Installer (Preview)
- [winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
- [PowerShell](https://aka.ms/wmf5download) 5 or later, [PowerShell Core](https://github.com/PowerShell/PowerShell) included
- Runtime execution policy of either: `Unrestricted`, `RemoteSigned` or `Bypass`

## Installation

Simply run the following command:

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser; .\install.ps1
```

> 🚨 While in active development, the installer is not configured to be a remote
> download. This will eventually change, but until then you'll need to download
> this project manually.

## TODO

### Applications

A living document of things I either am unable to automatically install, or the
more likely chance that I simply haven't tried to yet.

#### Drivers

- [ ] nVidia GeForce Experience
- [ ] Logitech Capture
- [ ] SteelSeries GG
- [ ] CORSAIR iCUE 3
  - `SYNTAQX-DEVBOX` cannot be upgraded to v4 as the H115i is not detected

#### Productivity

- [ ] CCleaner
- [ ] 1Password
- [ ] Adobe Creative Cloud
- [ ] Chrome Remote Desktop
- [ ] Discord
- [ ] Docker Desktop
- [ ] Git Credential Manager Core
- [ ] Git
- [ ] GitHub CLI
- [ ] Google Chrome
- [ ] GnuPg4Win
- [ ] Keybase
- [ ] Mozilla Firefox
- [ ] PostgreSQL 13
  - [ ] PostGIS Bundle
  - [ ] pgAgent
  - [ ] PgBouncer
- [ ] [ScreenToGif](https://www.screentogif.com)
- [ ] Slack
- [ ] Spotify
- [ ] PremiumSoft Navicat Premium 15.0
- [ ] Visual Studio Code
- [ ] Zoom

#### Gaming Platforms & Products

- [ ] Battle.net
  - [ ] World of Warcraft: Classic
- [ ] Riot Client
  - [ ] Valorant
- [ ] Steam
  - [ ] Apex Legends
  - [ ] olf with your friends

#### Development Tools

- [ ] [Go](https://golang.org/)
- [ ] Node.js
- [ ] Oracle VM VirtualBox 6.1.22 - *for Vagrant*
- [ ] Vagrant

##### World of Warcraft addon managers

- [ ] CurseForge
- [ ] Overwolf

## License

[MIT](./LICENSE)
