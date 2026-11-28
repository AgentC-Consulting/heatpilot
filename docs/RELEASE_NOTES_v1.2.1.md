**HeatPilot 1.2.1**: free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## What's new

- **Your Mac's administrator can now start HeatPilot's helper on their own.** On a managed Mac, the install can set up the fan helper without anyone opening HeatPilot, so cooling works from the first boot. If you install HeatPilot yourself, nothing changes.

1.1.0 and later update themselves. To get it now, choose Check for Updates… in the menu.

## Install

Download `HeatPilot-Installer.dmg`, open it, and drag HeatPilot onto Applications.

Or with Homebrew:

```
brew install --cask agentc-consulting/tap/heatpilot
```

## Verify

```
shasum -a 256 -c SHA256SUMS
gpg --verify SHA256SUMS.asc SHA256SUMS
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
```

`HeatPilot-Installer.dmg` SHA-256:
`13d0b52471f842d29b3be9697dfdd16241da1e479ba46ba95bcb505ef69be0a1`

Built from source commit `de53352` (HeatPilot 1.2.1, build 16). This is a customer release: the same build AgentC's managed Macs receive.

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key (`7C7636A83E58439F`).

