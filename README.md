<a href="https://github.com/AgentC-Consulting/heatpilot/releases/latest/download/HeatPilot-Installer.dmg">
  <img src="docs/brand/hero.svg" width="100%" alt="HeatPilot. Your Mac runs hot. This fixes that. A menu bar gauge shows a propeller spinning faster as the temperature climbs, then turning into a small plane when it is hot.">
</a>

<p align="center">
  <a href="https://github.com/AgentC-Consulting/heatpilot/releases/latest/download/HeatPilot-Installer.dmg"><img src="docs/brand/download.svg" width="380" alt="Download HeatPilot"></a>
</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/brand/badges-dark.svg">
    <img src="docs/brand/badges-light.svg" width="760" alt="Apple Silicon · macOS 14+ · Free for life · Signed and notarized · No account, no telemetry">
  </picture>
</p>

<p align="center">
  <b>HeatPilot turns your Mac's fans up before it gets hot.</b><br>
  One slider in your menu bar. Free for life.
</p>

<br>

## Your cockpit gauge

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/img/screens/gauge-dark.png">
    <img src="docs/img/screens/gauge-light.png" width="480" alt="HeatPilot's setup window: the live menu bar gauge, three styles (Instrument Plate, Glow, Plain), and switches for units, heat-colored digits, and Open at Login.">
  </picture>
</p>

<p align="center"><sub>Instrument Plate, Glow, or Plain. Digits in brass, or running blue to red as your Mac warms.</sub></p>

## One slider

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/brand/levels-dark.svg">
  <img src="docs/brand/levels-light.svg" width="100%" alt="The cooling slider. 0 leaves the fans to Apple. 1 to 9 start HeatPilot's curve earlier at each step, from 127°F at level 1 down to 99°F at level 9. 10 runs every fan at maximum.">
</picture>

0 is Apple's normal. 10 is every fan flat out. HeatPilot remembers your pick, even after a restart.

## The propeller tells you how hard your fans are working

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/brand/moods-dark.svg">
  <img src="docs/brand/moods-light.svg" width="100%" alt="Four menu bar propellers: still when the fans are stopped, a slow windmill when barely audible, a blur when working, and a small plane with wings and wheels when loud.">
</picture>

## Up and flying in three steps

<table>
  <tr>
    <td align="center" valign="top" width="33%">
      <img src="docs/img/screens/preflight.png" alt="Step 1: a preflight checklist confirms HeatPilot is in Applications and can control this Mac’s fans.">
      <p><b>1 · Preflight</b><br><sub>Drag it to Applications. HeatPilot checks it can reach your fans.</sub></p>
    </td>
    <td align="center" valign="top" width="33%">
      <img src="docs/img/screens/helper.png" alt="Step 2: allow the fan helper once in System Settings, with a drawing of the switch to flip.">
      <p><b>2 · Allow once</b><br><sub>Flip one switch in System Settings. No password after that.</sub></p>
    </td>
    <td align="center" valign="top" width="33%">
      <img src="docs/img/screens/cleared.png" alt="Step 3: every light green. The helper is allowed and running, so HeatPilot sets your fans with no password.">
      <p><b>3 · Cleared for takeoff</b><br><sub>Pick a look and a level from the menu bar. Done.</sub></p>
    </td>
  </tr>
</table>

## Built to hand control back

Every way HeatPilot can stop leads back to Apple's own fan control.

```mermaid
flowchart LR
    quit(["You quit HeatPilot"]) --> apple
    zero(["You pick level 0"]) --> apple
    logout(["Logout, shutdown, or the helper stops"]) --> apple
    fail(["A reading fails"]) --> apple
    apple{{"Apple's fan control takes over"}}
    classDef event fill:#2B3245,stroke:#938366,color:#ECE7DD
    classDef safe fill:#DAB56E,stroke:#8E7444,color:#23293A
    class quit,zero,logout,fail event
    class apple safe
```

- It never runs a fan slower than Apple would.
- Your level comes back after a restart. Fan speeds themselves never outlive one.
- No account, no tracking, no ads. It goes online only to check for its own updates.

> [!TIP]
> Trying Full Blast for the first time? Watch your temperatures for a few minutes before leaving it on.

## Questions

<details>
<summary><b>Will it work on my Mac?</b></summary>
<br>

Any Apple Silicon Mac with fans (MacBook Pro, Mac mini, Mac Studio, iMac, Mac Pro), on macOS 14 or newer. A MacBook Air has no fans, so there's nothing to turn up. HeatPilot still shows its temperatures.

</details>

<details>
<summary><b>Is it really free?</b></summary>
<br>

Yes, for life. [AgentC Consulting](https://agentc.consulting) builds Mac apps for businesses. This one's on us.

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/img/screens/about-dark.png">
    <img src="docs/img/screens/about-light.png" width="380" alt="HeatPilot's About window.">
  </picture>
</p>

</details>

<details>
<summary><b>How do I remove it?</b></summary>
<br>

Open the menu, hold <kbd>Option</kbd>, and choose **Remove Background Helper**. Then quit HeatPilot and drag it to the Trash.

</details>

<details>
<summary><b>Install with Homebrew</b></summary>
<br>

```bash
brew tap agentc-consulting/heatpilot https://github.com/AgentC-Consulting/heatpilot
brew install --cask heatpilot
```

</details>

<details>
<summary><b>Verify a download</b></summary>
<br>

Every release is signed with Apple Developer ID (`AgentC Consulting LLC (PXDF92M2T4)`), notarized by Apple, and ships a GPG-signed checksum file.

```bash
shasum -a 256 -c SHA256SUMS
gpg --verify SHA256SUMS.asc SHA256SUMS
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
```

HeatPilot checks for updates once a day and installs only updates that carry our signature.
Release notes: [1.1.3](docs/RELEASE_NOTES_v1.1.3.md) · [1.1.2](docs/RELEASE_NOTES_v1.1.2.md) · [1.1.1](docs/RELEASE_NOTES_v1.1.1.md) · [1.1.0](docs/RELEASE_NOTES_v1.1.0.md) · [1.0.0](docs/RELEASE_NOTES_v1.0.0.md)

</details>

## Something off?

[Report fan behavior or a bug](../../issues/new/choose). Your Mac model and the level you were on help most. No GitHub account? [Tell us here](https://agentc.consulting/heatpilot).

<br>

<p align="center"><a href="https://agentc.consulting"><picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/AgentC-Consulting/.github/main/brand/wordmark-dark.png">
  <img src="https://raw.githubusercontent.com/AgentC-Consulting/.github/main/brand/wordmark-light.png" alt="AgentC Consulting" width="220">
</picture></a></p>
