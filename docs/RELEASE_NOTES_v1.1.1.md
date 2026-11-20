**HeatPilot 1.1.1** — free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## What's new

- **Fly to Applications.** Open HeatPilot straight from the installer and it offers to park itself in Applications. One click, a short flight, and it reopens from there and ejects the installer.
- **A new installer window**, with a runway to drag across.
- **A clearer Welcome.** A picture for each step, a checklist that says what's ready, and dots you can click. The helper step now always shows its button (on some Macs it showed none).
- **Simpler controls.** °F / °C and Open at Login are now a two-sided switch instead of a rocker. Menu Bar Style shows your choice live, with Heat Colors as its own switch.
- **Lighter.** With heat-colored digits and loud fans, the menu app used 2.4% of a core. Now it's 0.13%.
- **The icon is back** on macOS 26, where 1.1.0's icon showed as a gray tile.
- The About window now says HeatPilot goes online to check for updates, which it does.

1.1.0 updates itself. To get it now, choose Check for Updates… in the menu.

## Install

Download `HeatPilot-Installer.dmg`, open it, and open HeatPilot. It takes it from there.

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
`d61081425491852f17558b33e4f77871863be2bb4a5de5fb6313fb328af31a5a`

Built from source commit `af928eb`.

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key (`7C7636A83E58439F`).
