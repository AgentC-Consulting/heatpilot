# HeatPilot

<img src="docs/img/about-logo.png" width="64" alt="The HeatPilot app icon">

**HeatPilot is a free, native macOS menu-bar fan controller** — built for
Apple Silicon, macOS 14 and later. Your Mac runs hot; Apple's fan curve
waits. HeatPilot gives you a cooler curve and a Full Blast button, with one
click back to Apple's defaults, always.

**[Download the latest release](../../releases/latest)** — free, and free for
life.

## What it does

- **Three modes, zero drama:**
  - **System Auto** — Apple's built-in thermal management, untouched. This is
    always one click away, and it's what quitting the app restores.
  - **Cooler Auto** — a conservative custom curve that starts nudging fan
    speed around 45 °C and gets meaningfully more aggressive around 65 °C
    (150 °F). It only ever raises fan speed above Apple's curve — it never
    lets your Mac run hotter than Apple would.
  - **Full Blast** — every fan at maximum RPM until you switch modes.
- **Live temperatures in your menu bar** — °F or °C following your system
  locale, with per-fan RPM detail in the dropdown.
- **No cloud, no account, no telemetry** — HeatPilot makes zero network
  calls. Cut your network; everything still works. All state is a few JSON
  files in `~/Library/Application Support/HeatPilot/`.
- **Free for life** — no trial, no subscription, no paywall.

## About the administrator password

The first time you pick **Cooler Auto** or **Full Blast**, macOS asks for
your administrator password — the prompt says exactly why: *"HeatPilot needs
administrator access to start its fan-control helper."*

That password starts a small bundled helper (`HeatPilotDaemon`) as root,
because writing fan speeds to Apple's SMC requires elevated privileges. The
menu-bar app itself never runs privileged, **System Auto never needs a
password**, and no unsupported Mac is ever shown the prompt at all.

## Safety

HeatPilot writes Apple SMC fan-control keys. It is built so the failure mode
is always "Apple takes back over":

- **System Auto** and **quitting the app** both restore Apple's automatic
  thermal management.
- The helper traps termination signals (kill, logout, shutdown) and restores
  Apple's control before exiting — fans are never left pinned at a manual
  RPM. (A force-kill with `kill -9` can't be trapped; reselect System Auto
  or reboot — manual fan targets do not survive a reboot.)
- After a minute of continuous System Auto the helper exits on its own, so
  no root process lingers.
- On Macs without controllable fans (MacBook Air) the control modes are
  disabled with a plain explanation — no password prompt, no helper.

As with any hardware-control tool: watch temperatures after first use, and
don't leave Full Blast running unattended until you trust it on your machine.

## Verify your download

Every release is signed with Apple Developer ID
(`AgentC Consulting LLC (PXDF92M2T4)`), notarized by Apple, and stapled —
Gatekeeper verifies it before first launch. Check for yourself:

```bash
spctl -a -t open --context context:primary-signature -vv HeatPilot-Installer.dmg
codesign -dv --verify /Applications/HeatPilot.app
shasum -a 256 -c SHA256SUMS   # SHA256SUMS ships with every release
```

`SHA256SUMS` is GPG-signed (`SHA256SUMS.asc`) with the AgentC Consulting
release key.

## Requirements

- An Apple Silicon Mac **with fans** (MacBook Pro, Mac mini, Mac Studio,
  iMac, Mac Pro). On fanless Macs, HeatPilot shows temperatures but disables
  fan control.
- macOS 14 Sonoma or later.
- Intel Macs are not supported.

## Install

1. Download `HeatPilot-Installer.dmg` from the
   [latest release](../../releases/latest), open it, and drag HeatPilot to
   Applications.
2. Launch HeatPilot — it lives in the menu bar (no Dock icon).
3. Pick a mode.

Or with Homebrew:

```bash
brew tap agentc-consulting/heatpilot https://github.com/AgentC-Consulting/heatpilot
brew install --cask heatpilot
```

## Uninstall

1. Pick **System Auto**, then **Quit HeatPilot** from the menu.
2. Delete `/Applications/HeatPilot.app`.
3. Delete `~/Library/Application Support/HeatPilot/`.

(Homebrew: `brew uninstall --zap heatpilot` does all of it.)

## Who made this

HeatPilot is made by [AgentC Consulting](https://agentc.consulting) — we
build native apps like this for clients, and we give this one away because
showing beats telling. Questions: agent_c@agentc.consulting
