**HeatPilot 1.1.0** — free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## What's new

- **Eleven cooling levels.** A slider from 0 (Apple manages the fans, exactly as macOS ships) to 10 (Full Blast). Level 5 is 1.0's Cooler Auto. Each level takes over from Apple only above a set temperature and never runs the fans quieter than Apple would, and the fans ease between speeds instead of jumping.
- **No more password prompts.** Allow HeatPilot's helper once in System Settings → Login Items, and changing the cooling level never asks for a password again. Prefer the 1.0 behavior? "Use a Password Instead" is still there.
- **A short Welcome.** Three steps on first launch: a preflight check, allowing the helper (it turns green by itself the moment you flip the switch), and finding your propeller in the menu bar. Reopen it any time from Getting Started… in the menu.
- **Menu bar styles.** The propeller spins faster as your fans get louder, and when they really work, you get a little surprise. Pick how it looks under Menu Bar Style: Instrument Plate (the default: brass on a navy plate, with digits that roll like an odometer), Instrument Plate with heat colors, Glow, Glow with heat colors, or Plain.
- **Automatic updates.** HeatPilot checks for a new version once a day (or when you choose Check for Updates…) and installs only updates signed with our release key. This is the last version you'll download by hand.
- **Light on your Mac.** Measured on a 10-core M-series MacBook Pro with HeatPilot driving both fans: the menu app averages 0.4% of one core, 13 MB, and under one wakeup a second; the helper 0.6% and 3 MB. Neither uses the GPU.

1.0 users: HeatPilot 1.0 can't update itself, so download this one and drag it over the old copy in Applications.

## Install

Download `HeatPilot-Installer.dmg`, open it, drag HeatPilot to Applications, and launch it. The Welcome window walks you through the rest.

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
`e974202f47bbedfd2f3acf74cc3bbec2f90df4f07249e225efa611c54f479260`

Built from source commit `7e1ec51`.

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key (`7C7636A83E58439F`).

## Requirements

Apple Silicon Mac with fans, macOS 14 (Sonoma) or later. Fanless Macs (MacBook Air) show temperatures with fan control turned off. Intel Macs are not supported.

## Still true

- No account, no telemetry. The only network request is the daily update check to GitHub.
- The helper hands the fans back to Apple on quit, logout, shutdown, or when the app is removed.
