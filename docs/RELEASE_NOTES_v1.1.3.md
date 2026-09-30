**HeatPilot 1.1.3** — free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## What's new

- **More cooling, sooner.** Turn the cooling up and the fans spin up in about three seconds. They still wind down gently.
- **Preferences, once you're set up.** After Start Flying, Getting Started becomes Preferences (⌘,): your menu bar look and settings, which apply as you change them. Leave setup partway and it stays Getting Started, back on the step you left.
- **A first-flight pointer.** The first time the menu opens after setup, the cooling slider flashes and asks to be dragged.
- **A smoother Welcome.** Continue on step 1 starts the engine first; the page slides over during the cut to the cockpit.
- **An even menu bar item.** The plane sits the same distance from the edge as from the number, and the item is back to temperature width.
- **Drag to land.** The installer window is back to dragging HeatPilot into Applications, now as a landing at the end of the runway.

1.1.0 and later update themselves. To get it now, choose Check for Updates… in the menu.

## Install

Download `HeatPilot-Installer.dmg`, open it, and drag HeatPilot onto Applications.

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
`7d6d09af3ef70ab74783713c6f94e9de0fbacd67087d59c239954e022cb95d9b`

Built from source commit `cbaa597`.

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key (`7C7636A83E58439F`).
