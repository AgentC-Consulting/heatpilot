**HeatPilot 1.1.2** — free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## What's new

- **Your cooling level sticks.** Quitting still hands the fans back to Apple, and HeatPilot picks your level back up when it opens again.
- **See the fans move.** Under the cooling slider, a bar shows where the fans are and where they're headed as they ease over. The slider now shows the level number, and the line under it stays current.
- **A steady menu bar.** The HeatPilot item keeps one width, whatever it's showing.
- **A Welcome that flows.** The engine starts, the cockpit idles while you set up the helper, and Continue takes off. The window stays one size, and it reopens on the step you were on.
- **Double-click to install.** Open HeatPilot from the installer and it flies itself into Applications. Afterward it asks whether to put the installer in the Trash.

1.1.0 and 1.1.1 update themselves. To get it now, choose Check for Updates… in the menu.

## Install

Download `HeatPilot-Installer.dmg`, open it, and double-click HeatPilot.

Or with Homebrew:

```
brew tap agentc-consulting/heatpilot https://github.com/AgentC-Consulting/heatpilot
brew install --cask heatpilot
```

## Verify

```
shasum -a 256 -c SHA256SUMS
gpg --verify SHA256SUMS.asc SHA256SUMS
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
```

`HeatPilot-Installer.dmg` SHA-256:
`bbe73b02a9baea7cc849298834b50162e3c45f658d0c75c46e3ac634fdb5b1d1`

Built from source commit `a30470a`.

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key (`7C7636A83E58439F`).
