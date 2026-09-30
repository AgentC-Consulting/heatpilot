<p align="center">
  <a href="https://github.com/AgentC-Consulting/heatpilot/releases/latest/download/HeatPilot-Installer.dmg">
    <img src="docs/img/social-preview.png" width="100%" alt="HeatPilot. Your Mac runs hot. This fixes that.">
  </a>
</p>

<p align="center">
  <a href="https://github.com/AgentC-Consulting/heatpilot/releases/latest/download/HeatPilot-Installer.dmg">
    <img src="docs/img/download-button.png" width="360" alt="Download HeatPilot">
  </a>
</p>

<p align="center">
  Free &nbsp;·&nbsp; For Apple Silicon Macs &nbsp;·&nbsp; macOS 14 or newer
</p>

<br>

HeatPilot is a free menu bar app that turns your Mac's fans up before it gets hot.
One slider, right in your menu bar.

## Get started

1. **Download** and drag HeatPilot to Applications.
2. **Allow** it once in System Settings. That's the only time it asks.
3. **Pick a level** from the menu bar. 0 is Apple's normal. 10 is full blast.

## Nothing to worry about

- It never runs your fans slower than Apple would.
- Quit it, and your Mac goes right back to normal.
- No account, no tracking, no ads. It updates itself.

## Questions

**Will it work on my Mac?**
Any Apple Silicon Mac with fans, on macOS 14 or newer. A MacBook Air has no fans, so there's nothing to turn up.

**Is it really free?**
Yes. [AgentC Consulting](https://agentc.consulting) builds Mac apps for businesses. This one's on us.

**How do I remove it?**
Quit it and drag it to the Trash.

**Something off?**
[Open an issue](../../issues), or [tell us without a GitHub account](https://agentc.consulting/heatpilot).

<details>
<summary><b>Install with Homebrew</b></summary>

```bash
brew tap agentc-consulting/heatpilot https://github.com/AgentC-Consulting/heatpilot
brew install --cask heatpilot
```

</details>

<details>
<summary><b>Verify a download</b></summary>

Every release is signed with Apple Developer ID (`AgentC Consulting LLC (PXDF92M2T4)`), notarized by Apple, and ships a GPG-signed checksum file.

```bash
shasum -a 256 -c SHA256SUMS
gpg --verify SHA256SUMS.asc SHA256SUMS
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
```

HeatPilot checks this page for updates once a day and installs only updates that carry our signature.
Release notes: [1.1.0](docs/RELEASE_NOTES_v1.1.0.md) · [1.0.0](docs/RELEASE_NOTES_v1.0.0.md)

</details>

<br>

<p align="center"><a href="https://agentc.consulting"><picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/AgentC-Consulting/.github/main/brand/wordmark-dark.png">
  <img src="https://raw.githubusercontent.com/AgentC-Consulting/.github/main/brand/wordmark-light.png" alt="AgentC Consulting" width="220">
</picture></a></p>
