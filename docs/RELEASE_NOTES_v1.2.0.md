**HeatPilot 1.2.0**: free menu-bar fan control for Apple Silicon Macs.

Signed with Apple Developer ID (AgentC Consulting LLC), notarized by Apple, and stapled.

## What's new

- **Autopilot.** Your coding assistant can work the fans. It reads your Mac's temperatures, sets the cooling level up or down, and turns the fans up during big builds and test runs, then hands them back. Turn it on in the Welcome window's Autopilot step, or **Autopilot…** in the menu, and pick the assistants: Claude Code, Claude Desktop, Codex (ChatGPT), and Gemini CLI.
- **Autopilot only adds cooling, and it always ends.** Rules and boosts can raise the fans above the level you chose, never below it. Every boost ends on its own within 30 minutes.
- **Autopilot comes out cleanly.** **Remove** on the Autopilot step puts each assistant's settings back as they were. Hold Option in the menu for **Reset Autopilot**.
- **Cooling while nobody is signed in, for managed Macs.** A Mac that AgentC manages can now keep a cooling level, and Autopilot rules, at the login window and when nobody is signed in. The setting comes from a device profile the Mac's administrator installs. When someone signs in, their own HeatPilot settings take over, exactly as before. On a Mac without that profile, nothing changes.

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
`32d64765dfcdfd3bae9cf1507f29c464ea36308907ede8a6b1fa0112ed6872ab`

Built from source commit `c7478a9` (HeatPilot 1.2.0, build 15). This is a customer release: the same build AgentC's managed Macs receive.

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting release key (`7C7636A83E58439F`).
