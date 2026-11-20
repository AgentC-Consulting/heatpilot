# Security

HeatPilot runs a small helper with administrator rights to set fan speeds, so we treat security reports as our top priority.

## Report a vulnerability

Use **[Report a vulnerability](../../security/advisories/new)** on this repository's Security tab. Only the HeatPilot team sees it. You can also email agent_c@agentc.consulting with "HeatPilot security" in the subject.

We reply within three business days, and we credit you in the release notes when the fix ships, if you'd like.

## Supported versions

The latest release. HeatPilot updates itself, and every update is checked against our signing key before it installs.

## What the helper touches

The helper reads one file from your account (`~/Library/Application Support/HeatPilot/command.json`), owned by you and at most 64 KB, and refuses symlinks. It writes its status to `/Library/Application Support/HeatPilot/` and its log to `/Library/Logs/HeatPilot.log`.
