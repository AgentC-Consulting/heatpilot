#!/usr/bin/ruby
# Builds HeatPilot's README art (both themes) into the folder given as ARGV[0].
require_relative 'kit'
include Kit

OUT_DIR = ARGV[0] or abort 'usage: assets.rb <out-dir>'

def save(name, svg)
  File.write(File.join(OUT_DIR, name), svg)
  puts "#{name}: #{File.size(File.join(OUT_DIR, name))} bytes"
end

# ---------------------------------------------------------------- badges
def badges(palette, theme)
  list_of_badges = [
    ['APPLE SILICON', :plate, true],
    ['macOS 14+', :plate, false],
    ['FREE FOR LIFE', :gold, false],
    ['SIGNED + NOTARIZED', :plate, false],
    ['NO ACCOUNT · NO TELEMETRY', :plate, false]
  ]
  height = 40
  gap = 12
  font_size = 13
  cursor = 2
  parts = []
  list_of_badges.each do |label, style, with_mark|
    text_w = text_width('FiraMono-Medium', font_size, 0.14, label)
    mark_w = with_mark ? 24 : 0
    width = (text_w + 36 + mark_w).round
    fill = style == :gold ? "url(#gold-#{theme})" : "url(#face-#{theme})"
    stroke = style == :gold ? '#B8934F' : "url(#rim-#{theme})"
    ink = style == :gold ? palette[:ink] : palette[:text]
    parts << %(<rect x="#{cursor}" y="2" width="#{width}" height="#{height}" rx="#{height / 2}" fill="#{fill}" stroke="#{stroke}" stroke-width="1.6"/>)
    left = cursor + 18
    if with_mark
      parts << propeller_mark(left + 8, 2 + height / 2.0, 1.15, "url(#brass-#{theme})", palette[:face_bottom])
      left += mark_w
    end
    parts << text_at('FiraMono-Medium', font_size, 0.14, label, left: left, baseline: 2 + height / 2.0 + 4.6, fill: ink)
    cursor += width + gap
  end
  total = cursor - gap + 2
  svg_open(total, height + 4, 'Apple Silicon, macOS 14 or later, free for life, signed and notarized, no account and no telemetry',
           'Five brass-rimmed instrument-plate badges.') +
    %(<defs>#{face_gradient("face-#{theme}", palette)}#{rim_gradient("rim-#{theme}")}#{brass_gradient("brass-#{theme}")}) +
    %(<linearGradient id="gold-#{theme}" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#E7C888"/><stop offset="1" stop-color="#{GOLD}"/></linearGradient></defs>) +
    parts.join + '</svg>'
end

save('badges-dark.svg', badges(DARK, 'dark'))
save('badges-light.svg', badges(LIGHT, 'light'))

# ------------------------------------------------------- download button
def download_button
  width = 520
  height = 92
  label = 'Download HeatPilot'
  label_w = text_width('FiraSans-SemiBold', 32, 0, label)
  mark_size = 30
  block_w = mark_size + 18 + label_w
  left = (width - block_w) / 2.0
  svg_open(width, height, 'Download HeatPilot', 'A gold button with a propeller.') +
    %(<defs><linearGradient id="g" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#EBCD8F"/><stop offset="1" stop-color="#{GOLD}"/></linearGradient>) +
    %(<style>.p{animation:s 6s linear infinite;transform-origin:0 0}@keyframes s{to{transform:rotate(360deg)}}@media (prefers-reduced-motion:reduce){.p{animation:none}}</style></defs>) +
    %(<rect x="1.5" y="1.5" width="#{width - 3}" height="#{height - 3}" rx="#{(height - 3) / 2}" fill="url(#g)" stroke="#B8934F" stroke-width="2"/>) +
    %(<rect x="6" y="6" width="#{width - 12}" height="#{height - 12}" rx="#{(height - 12) / 2}" fill="none" stroke="#FFFFFF" stroke-opacity=".35" stroke-width="1.5"/>) +
    %(<g transform="translate(#{left + mark_size / 2.0} #{height / 2.0}) scale(2)"><g class="p"><path fill="#23293A" d="#{Propeller.blades(7.6)}"/></g>) +
    %(<path fill="#{GOLD}" d="#{Propeller.circle_d(1.0)}"/></g>) +
    text_at('FiraSans-SemiBold', 32, 0, label, left: left + mark_size + 18, baseline: height / 2.0 + 11, fill: '#23293A') +
    '</svg>'
end

save('download.svg', download_button)

# ------------------------------------------------------------ the slider
def levels(palette, theme)
  width = 1000
  height = 300
  left = 70
  step = 86
  base = 196
  bars = []
  (0..10).each do |level|
    bar_center = left + level * step
    case level
    when 0
      bars << %(<rect x="#{bar_center - 22}" y="#{base - 34}" width="44" height="34" rx="6" fill="none" stroke="#{palette[:edge]}" stroke-width="2" stroke-dasharray="5 4"/>)
      bars << propeller_mark(bar_center, base - 17, 1.25, palette[:muted], palette[:panel])
    when 10
      bars << %(<rect x="#{bar_center - 22}" y="#{base - 150}" width="44" height="150" rx="6" fill="url(#hot-#{theme})"/>)
    else
      bar_height = 34 + level * 10.5
      bars << %(<rect x="#{bar_center - 22}" y="#{(base - bar_height).round(1)}" width="44" height="#{bar_height.round(1)}" rx="6" fill="url(#brassbar-#{theme})" opacity="#{(0.55 + level * 0.045).round(2)}"/>)
    end
    weight = level == 5 ? 'FiraMono-Medium' : 'FiraMono-Regular'
    bars << text_at(weight, 20, 0, level.to_s, left: bar_center, baseline: base + 34, fill: level == 5 ? palette[:accent] : palette[:text], anchor: :middle)
    next unless (1..9).cover?(level)

    start_f = ((45 + (5 - level) * 2) * 9.0 / 5 + 32).round
    bars << text_at('FiraMono-Regular', 13, 0, "#{start_f}°F", left: bar_center, baseline: base + 58, fill: palette[:muted], anchor: :middle)
  end
  favorite_x = left + 5 * step
  marker = %(<path d="M#{favorite_x - 7} #{base - 102}L#{favorite_x + 7} #{base - 102}L#{favorite_x} #{base - 92}Z" fill="#{palette[:accent]}"/>) +
           text_at('FiraMono-Medium', 12, 0.16, 'CLASSIC', left: favorite_x, baseline: base - 110, fill: palette[:accent], anchor: :middle)
  zones = text_at('FiraMono-Medium', 12, 0.18, 'APPLE', left: left, baseline: 30, fill: palette[:muted], anchor: :middle) +
          text_at('FiraMono-Medium', 12, 0.18, 'HEATPILOT’S CURVE: EACH STEP STARTS EARLIER AND RUNS HARDER', left: left + 5 * step, baseline: 30, fill: palette[:muted], anchor: :middle) +
          text_at('FiraMono-Medium', 12, 0.18, 'FULL BLAST', left: left + 10 * step, baseline: 30, fill: palette[:muted], anchor: :middle) +
          %(<path d="M#{left + step - 22} 42H#{left + 9 * step + 22}" stroke="#{palette[:edge]}" stroke-width="1.5"/>) +
          %(<path d="M#{left + step - 22} 38V46M#{left + 9 * step + 22} 38V46" stroke="#{palette[:edge]}" stroke-width="1.5"/>)
  footer = text_at('FiraSans-Regular', 15, 0, 'Under each level: the temperature where HeatPilot starts adding fan speed. It never runs a fan slower than Apple would.',
                   left: width / 2.0, baseline: height - 12, fill: palette[:muted], anchor: :middle)
  svg_open(width, height, 'The cooling slider, 0 to 10',
           'Level 0 leaves the fans to Apple. Levels 1 to 9 start HeatPilot\'s curve earlier at each step, from 127 degrees Fahrenheit at level 1 to 99 at level 9. Level 10 runs every fan at maximum.') +
    %(<defs><linearGradient id="brassbar-#{theme}" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#E9C987"/><stop offset="1" stop-color="#B8934F"/></linearGradient>) +
    %(<linearGradient id="hot-#{theme}" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#E8877A"/><stop offset=".6" stop-color="#E0A066"/><stop offset="1" stop-color="#{GOLD}"/></linearGradient></defs>) +
    %(<path d="M#{left - 40} #{base + 1}H#{left + 10 * step + 40}" stroke="#{palette[:edge]}" stroke-width="2"/>) +
    zones + bars.join + marker + footer + '</svg>'
end

save('levels-dark.svg', levels(DARK, 'dark'))
save('levels-light.svg', levels(LIGHT, 'light'))

# ------------------------------------------------- the icon's four moods
def moods(palette, theme)
  width = 1000
  height = 230
  list_of_moods = [
    ['FANS STOPPED', 'Holds still', :still],
    ['BARELY AUDIBLE', 'Turns like a windmill', :slow],
    ['WORKING', 'Spins up to a blur', :fast],
    ['LOUD, OR PAST 90°C', 'Grows wings and flies', :plane]
  ]
  column_w = width / 4.0
  css = <<~CSS
    <style>
      .slow { animation: turn 3.2s linear infinite; transform-origin: 0 0; }
      .fast { animation: turn .38s linear infinite; transform-origin: 0 0; }
      .fly { animation: turn .22s linear infinite; transform-origin: 0 0; }
      .buck { animation: buck 1.6s ease-in-out infinite; transform-origin: 0 0; }
      .wisp { stroke-dasharray: 3 9; animation: stream .45s linear infinite; }
      @keyframes turn { to { transform: rotate(360deg); } }
      @keyframes buck { 0%, 100% { transform: translate(0, 0) rotate(0); } 25% { transform: translate(0, -.4px) rotate(-3deg); } 50% { transform: translate(0, .3px) rotate(2deg); } 75% { transform: translate(0, -.2px) rotate(-1.5deg); } }
      @keyframes stream { to { stroke-dashoffset: -12; } }
      @media (prefers-reduced-motion: reduce) { .slow, .fast, .fly, .buck, .wisp { animation: none; } }
    </style>
  CSS
  body = list_of_moods.each_with_index.map do |(heading, line, mood), index|
    center_x = column_w * index + column_w / 2
    plate_w = 196
    plate_h = 112
    plate_top = 14
    center_y = plate_top + plate_h / 2.0 + (mood == :plane ? 4 : 0)
    plate = %(<rect x="#{center_x - plate_w / 2}" y="#{plate_top}" width="#{plate_w}" height="#{plate_h}" rx="#{plate_h / 2}" fill="url(#face-#{theme})" stroke="url(#rim-#{theme})" stroke-width="3"/>)
    scale = mood == :plane ? 4.7 : 5.6
    blades = %(<path fill="url(#brass-#{theme})" d="#{Propeller.blades(mood == :plane ? 6.0 : 7.6)}"/>)
    hub = %(<path fill="#{GOLD}" d="#{Propeller.circle_d(1.7)}"/><path fill="#{palette[:face_bottom]}" d="#{Propeller.circle_d(0.75)}"/>)
    icon = case mood
           when :still then blades + hub
           when :slow then %(<g class="slow">#{blades}</g>) + hub
           when :fast then %(<path fill="#{GOLD}" opacity=".28" d="#{Propeller.circle_d(7.4)}"/><g class="fast" opacity=".6">#{blades}</g>) + hub
           else
             wisps = %(<g fill="none" stroke="#{palette[:text]}" stroke-opacity=".6" stroke-width=".35" stroke-linecap="round">) +
                     %(<path class="wisp" transform="translate(5 -6.5)" d="#{Propeller.wisp(6)}"/><path class="wisp" transform="translate(-5 -5.5) scale(-1 1)" d="#{Propeller.wisp(6)}"/>) +
                     %(<path class="wisp" transform="translate(6 3.5)" d="#{Propeller.wisp(5)}"/><path class="wisp" transform="translate(-6 4.5) scale(-1 1)" d="#{Propeller.wisp(5)}"/></g>)
             %(<g class="buck">#{wisps}<path fill="#B79558" d="#{Propeller.gear}"/><path fill="#C9A462" d="#{Propeller.wings}"/>) +
               %(<path fill="#B79558" d="#{Propeller.fin}"/><path fill="#8E7444" d="#{Propeller.circle_d(3.6)}"/>) +
               %(<path fill="#{GOLD}" opacity=".45" d="#{Propeller.circle_d(6.2)}"/><g class="fly" opacity=".4">#{blades}</g>#{hub}</g>)
           end
    plate + %(<g transform="translate(#{center_x} #{center_y}) scale(#{scale})">#{icon}</g>) +
      text_at('FiraMono-Medium', 12.5, 0.16, heading, left: center_x, baseline: 168, fill: palette[:accent], anchor: :middle) +
      text_at('FiraSans-Regular', 18, 0, line, left: center_x, baseline: 196, fill: palette[:text], anchor: :middle)
  end.join
  svg_open(width, height, 'The menu bar propeller reacts to fan noise',
           'Four plates: a still propeller when the fans are stopped, a slow windmill when barely audible, a fast blur when working, and a small plane with wings and wheels when loud or past 90 degrees Celsius.') +
    %(<defs>#{face_gradient("face-#{theme}", palette)}#{rim_gradient("rim-#{theme}")}#{brass_gradient("brass-#{theme}")}</defs>) + css + body + '</svg>'
end

save('moods-dark.svg', moods(DARK, 'dark'))
save('moods-light.svg', moods(LIGHT, 'light'))
