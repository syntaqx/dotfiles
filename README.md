# .dotfiles ~/

Personal dotfiles, period.

> 🚧 __Extremely WIP!__ The repository is mostly functioning as functional
> notes, so it may not work as expected. Proceed at your own risk.

## Prerequisites

- Windows 10 v1709 (10.0.16299) or later
- Windows Insider Preview (flight ring)
- Windows App Installer (Preview)
- [winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)

## Installation

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
.\install.ps1
```

> This command will be changing over to a remote installer, but wanted to get
> it fully working first.

## TODO

### Applications

A living document of things I either am unable to automatically install, or the
more likely chance that I simply haven't tried to yet.

#### Drivers

- [ ] nVidia GeForce Experience
- [ ] Logitech Capture
- [ ] SteelSeries GG

#### Productivity

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
