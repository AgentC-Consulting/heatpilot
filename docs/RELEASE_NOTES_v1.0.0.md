**HeatPilot 1.0.0** — free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## Install

Download `HeatPilot-Installer.dmg`, open it, drag HeatPilot to Applications, launch. The first time you pick Cooler Auto or Full Blast, macOS asks for your administrator password to start the fan-control helper — [here's exactly why](https://github.com/AgentC-Consulting/heatpilot#about-the-administrator-password).

## Verify

```
shasum -a 256 -c SHA256SUMS
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
```

`HeatPilot-Installer.dmg` SHA-256:
`11dc7b0ee1f9a3ca079753ab33ae8a07619d928bffb2ec66e45086aef058a343`

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key.

## Requirements

Apple Silicon Mac with fans, macOS 14+. Fanless Macs (MacBook Air) show temperatures with fan control disabled. Intel Macs are not supported.

## What's inside

- Three modes: System Auto (Apple's defaults), Cooler Auto (earlier, cooler curve), Full Blast.
- Live menu-bar temperature (°F/°C by locale), per-fan RPM detail.
- No network calls, no account, no telemetry.
- Safety-first helper: restores Apple's thermal management on quit, kill, logout, or shutdown, and exits on its own after a minute of System Auto.
