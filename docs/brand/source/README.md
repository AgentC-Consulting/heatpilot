# README art

Every picture in `docs/brand/` is generated from HeatPilot's own drawing code: the propeller and plane shapes are a port of `PropellerGeometry.swift`, the colors are the AgentC Mac UI kit tokens, and all text is outlined from the brand fonts (Michroma, Fira Sans, Fira Mono, SIL OFL), so GitHub renders it exactly with no font loading.

```bash
swiftc -O textpath.swift -o textpath          # CoreText text-to-path tool
mkdir -p ../fonts                              # copy the verified fonts from the app's Packaging/Fonts
/usr/bin/ruby hero.rb cockpit.jpg ../hero.svg  # the animated banner (cockpit photo: the app's about-banner.jpg)
/usr/bin/ruby assets.rb ..                     # badges, download button, slider, propeller moods (light and dark)
```

Animations are CSS inside the SVG and stop under Reduce Motion.
