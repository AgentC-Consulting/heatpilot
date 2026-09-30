# HeatPilot

<img src="docs/img/about-logo.png" width="64" alt="The HeatPilot app icon">

![Apple Silicon](https://img.shields.io/badge/Apple_Silicon-M--series_only-1c212e)
![macOS 14+](https://img.shields.io/badge/macOS-14%2B-1c212e)
![Free](https://img.shields.io/badge/free-for_life-dab56e)
![Signed & notarized](https://img.shields.io/badge/signed-Developer_ID_%C2%B7_notarized-1c212e)

**Your Mac runs hot. Apple waits. HeatPilot doesn't.**

HeatPilot is a free menu bar app that turns your Mac's fans up before it gets hot.
One slider, right in your menu bar.

**[Download HeatPilot](https://github.com/AgentC-Consulting/heatpilot/releases/latest/download/HeatPilot-Installer.dmg)** · [agentc.consulting/heatpilot](https://agentc.consulting/heatpilot)

## Up and running in a minute

1. Drag HeatPilot to Applications and open it.
2. Click **Allow** once in System Settings. That's the only time it asks.
3. Pick a level from the menu bar. 0 is Apple's normal. 10 is full blast.

Or with Homebrew:

```bash
brew tap agentc-consulting/heatpilot https://github.com/AgentC-Consulting/heatpilot
brew install --cask heatpilot
```

## Nothing to worry about

- It never runs your fans slower than Apple would.
- Quit it, and your Mac goes right back to normal.
- No account, no tracking, no ads. It updates itself.

## Questions

**Will it work on my Mac?** Any Apple Silicon Mac with fans, on macOS 14 or newer.
A MacBook Air has no fans, so there's nothing to turn up. Intel Macs aren't supported.

**Is it really free?** Yes. [AgentC Consulting](https://agentc.consulting) builds Mac
apps for businesses. This one's on us.

**How do I remove it?** Quit it and drag it to the Trash.
(Homebrew: `brew uninstall --zap heatpilot`.)

**Does it go online?** Once a day, to check this page for an update. Updates install
only if they carry our signature.

**Something off?** [Open an issue](../../issues), or tell us without a GitHub account
at [agentc.consulting/heatpilot](https://agentc.consulting/heatpilot). Your Mac model
and macOS version help.

## Verify a download

Every release is signed with Apple Developer ID (`AgentC Consulting LLC (PXDF92M2T4)`),
notarized by Apple, and ships a GPG-signed checksum file.

```bash
shasum -a 256 -c SHA256SUMS
gpg --verify SHA256SUMS.asc SHA256SUMS
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
```

Release notes: [1.1.0](docs/RELEASE_NOTES_v1.1.0.md) · [1.0.0](docs/RELEASE_NOTES_v1.0.0.md)

---

<p align="center"><a href="https://agentc.consulting"><picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/AgentC-Consulting/.github/main/brand/wordmark-dark.png">
  <img src="https://raw.githubusercontent.com/AgentC-Consulting/.github/main/brand/wordmark-light.png" alt="AgentC Consulting" width="220">
</picture></a></p>
