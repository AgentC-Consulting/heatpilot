#!/usr/bin/ruby
# Builds docs/brand/hero.svg: the animated README banner for HeatPilot.
require 'base64'
require_relative 'propeller'

HERE = __dir__
FONTS = File.join(HERE, '..', 'fonts')
TEXTPATH = File.join(HERE, 'textpath')
PHOTO = ARGV[0] or abort 'usage: hero.rb <cockpit.jpg> <out.svg>'
OUT = ARGV[1]

def text_shape(font_name, size, tracking, text)
  width, path_data = IO.popen([TEXTPATH, File.join(FONTS, "#{font_name}.ttf"), size.to_s, tracking.to_s, text], &:read).strip.split("\t", 2)
  [width.to_f, path_data]
end

def text_at(font_name, size, tracking, text, left:, baseline:, fill:, anchor: :start, extra: '')
  width, path_data = text_shape(font_name, size, tracking, text)
  left -= width / 2 if anchor == :middle
  left -= width if anchor == :end
  %(<path transform="translate(#{left.round(2)} #{baseline})" fill="#{fill}" d="#{path_data}"#{extra}/>)
end

photo_data = Base64.strict_encode64(File.binread(PHOTO))

GOLD = '#DAB56E'
PARCHMENT = '#F4EFE6'
MUTED = '#CFC6B6'
NAVY = '#23293A'
DEEP = '#141621'

# The live gauge: an instrument plate the way the menu bar draws it, scaled up.
plate_left = 800
plate_top = 132
plate_width = 420
plate_height = 164
icon_center_x = plate_left + 122
icon_center_y = plate_top + plate_height / 2.0 + 4
icon_scale = 6.3
digit_window_left = plate_left + 236
digit_window_width = 160
digit_size = 64
digit_row = 100
digit_baseline = plate_top + plate_height / 2.0 + 20
temperatures = [['142F', '#9CC3E6'], ['158F', GOLD], ['187F', '#E8877A'], ['149F', GOLD], ['142F', '#9CC3E6']]

digit_strip = temperatures.each_with_index.map do |(label, color), index|
  text_at('FiraMono-Medium', digit_size, -0.02, label, left: digit_window_left + 4, baseline: digit_baseline + index * digit_row, fill: color)
end.join("\n      ")

propeller_blades = Propeller.blades(7.6)
hub = Propeller.circle_d(1.7)

svg = <<~SVG
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1280 440" width="1280" height="440" role="img" aria-labelledby="title desc">
    <title id="title">HeatPilot: your Mac runs hot. This fixes that.</title>
    <desc id="desc">A cockpit at sunset. HeatPilot's menu bar gauge shows the propeller spinning faster as the temperature climbs from 142 to 187 degrees Fahrenheit, turning into a small plane when it is hot, then folding back as it cools.</desc>
    <style>
      .spin { animation: spin 14s linear infinite; transform-origin: 0 0; }
      .blades { animation: blades 14s linear infinite; }
      .blur { animation: blur 14s linear infinite; opacity: 0; }
      .wings { animation: wings 14s ease-in-out infinite; transform-origin: 0 0; transform: scale(0.18, 1); opacity: 0; }
      .fin { animation: fin 14s ease-in-out infinite; transform-origin: 0 0; transform: scale(1, 0); opacity: 0; }
      .gear { animation: gear 14s ease-in-out infinite; transform-origin: 0 -1.6px; transform: scale(1, 0); opacity: 0; }
      .body { animation: body 14s ease-in-out infinite; transform-origin: 0 0; transform: scale(0.55); }
      .buck { animation: buck 14s ease-in-out infinite; transform-origin: 0 0; }
      .wisps { animation: wisps 14s linear infinite; opacity: 0; }
      .wisp { stroke-dasharray: 3 9; animation: stream .45s linear infinite; }
      .roll { animation: roll 14s cubic-bezier(.6,0,.3,1) infinite; }
      .glow { animation: glow 14s ease-in-out infinite; opacity: .0; }
      @keyframes spin { 0% { transform: rotate(0deg); } 25% { transform: rotate(360deg); } 45% { transform: rotate(1440deg); } 80% { transform: rotate(7200deg); } 100% { transform: rotate(7920deg); } }
      @keyframes blades { 0%, 46% { opacity: 1; } 54%, 76% { opacity: .35; } 84%, 100% { opacity: 1; } }
      @keyframes blur { 0%, 44% { opacity: 0; } 54%, 76% { opacity: .55; } 84%, 100% { opacity: 0; } }
      @keyframes wings { 0%, 48% { transform: scale(.18, 1); opacity: 0; } 58%, 76% { transform: scale(1, 1); opacity: 1; } 86%, 100% { transform: scale(.18, 1); opacity: 0; } }
      @keyframes fin { 0%, 50% { transform: scale(1, 0); opacity: 0; } 60%, 76% { transform: scale(1, 1); opacity: 1; } 84%, 100% { transform: scale(1, 0); opacity: 0; } }
      @keyframes gear { 0%, 54% { transform: scale(1, 0); opacity: 0; } 62%, 74% { transform: scale(1, 1); opacity: 1; } 80%, 100% { transform: scale(1, 0); opacity: 0; } }
      @keyframes body { 0%, 48% { transform: scale(.55); } 58%, 76% { transform: scale(1); } 86%, 100% { transform: scale(.55); } }
      @keyframes buck { 0%, 56% { transform: translate(0, 0) rotate(0deg); } 60% { transform: translate(0, -.5px) rotate(-3deg); } 63% { transform: translate(0, .4px) rotate(2deg); } 66% { transform: translate(0, -.3px) rotate(-2deg); } 69% { transform: translate(0, .5px) rotate(3deg); } 72% { transform: translate(0, -.2px) rotate(-1deg); } 76%, 100% { transform: translate(0, 0) rotate(0deg); } }
      @keyframes wisps { 0%, 56% { opacity: 0; } 61%, 74% { opacity: 1; } 79%, 100% { opacity: 0; } }
      @keyframes stream { to { stroke-dashoffset: -12; } }
      @keyframes roll { 0%, 22% { transform: translateY(0); } 26%, 42% { transform: translateY(-#{digit_row}px); } 46%, 77% { transform: translateY(-#{digit_row * 2}px); } 81%, 96% { transform: translateY(-#{digit_row * 3}px); } 100% { transform: translateY(-#{digit_row * 4}px); } }
      @keyframes glow { 0%, 46% { opacity: 0; } 58%, 76% { opacity: .55; } 88%, 100% { opacity: 0; } }
      @media (prefers-reduced-motion: reduce) { .spin, .blades, .blur, .wings, .fin, .gear, .body, .buck, .wisps, .wisp, .roll, .glow { animation: none; } }
    </style>
    <defs>
      <clipPath id="card"><rect width="1280" height="440" rx="22"/></clipPath>
      <clipPath id="digits"><rect x="#{digit_window_left}" y="#{plate_top + 18}" width="#{digit_window_width}" height="#{plate_height - 36}"/></clipPath>
      <linearGradient id="shade" x1="0" x2="1" y1="0" y2="0">
        <stop offset="0" stop-color="#{DEEP}" stop-opacity=".95"/>
        <stop offset=".46" stop-color="#{DEEP}" stop-opacity=".78"/>
        <stop offset="1" stop-color="#{DEEP}" stop-opacity=".30"/>
      </linearGradient>
      <linearGradient id="floor" x1="0" x2="0" y1="0" y2="1">
        <stop offset=".55" stop-color="#{DEEP}" stop-opacity="0"/>
        <stop offset="1" stop-color="#{DEEP}" stop-opacity=".85"/>
      </linearGradient>
      <linearGradient id="rim" x1="0" x2="0" y1="0" y2="1">
        <stop offset="0" stop-color="#F0D49A"/>
        <stop offset=".5" stop-color="#{GOLD}"/>
        <stop offset="1" stop-color="#8E7444"/>
      </linearGradient>
      <linearGradient id="face" x1="0" x2="0" y1="0" y2="1">
        <stop offset="0" stop-color="#2E3550"/>
        <stop offset="1" stop-color="#1A1F2D"/>
      </linearGradient>
      <radialGradient id="brass" cx="0" cy="0" r="8" gradientUnits="userSpaceOnUse">
        <stop offset="0" stop-color="#D2744A"/>
        <stop offset=".45" stop-color="#E0A066"/>
        <stop offset="1" stop-color="#{GOLD}"/>
      </radialGradient>
      <radialGradient id="heat" cx=".5" cy=".5" r=".5">
        <stop offset="0" stop-color="#E8877A" stop-opacity=".9"/>
        <stop offset="1" stop-color="#E8877A" stop-opacity="0"/>
      </radialGradient>
    </defs>

    <g clip-path="url(#card)">
      <rect width="1280" height="440" fill="#{DEEP}"/>
      <image x="0" y="-104" width="1280" height="543" preserveAspectRatio="xMidYMid slice" href="data:image/jpeg;base64,#{photo_data}" xlink:href="data:image/jpeg;base64,#{photo_data}"/>
      <rect width="1280" height="440" fill="url(#shade)"/>
      <rect width="1280" height="440" fill="url(#floor)"/>

      <!-- wordmark -->
      <g transform="translate(86 86) scale(2.6)">
        <path fill="url(#brass)" d="#{propeller_blades}"/>
        <path fill="#{DEEP}" d="#{Propeller.circle_d(1.0)}"/>
      </g>
      #{text_at('Michroma-Regular', 26, 0.32, 'HEATPILOT', left: 124, baseline: 99, fill: PARCHMENT)}

      #{text_at('FiraMono-Medium', 17, 0.16, 'FREE FOR LIFE  ·  SIGNED  ·  APPLE SILICON', left: 64, baseline: 198, fill: GOLD)}
      #{text_at('FiraSans-SemiBold', 58, 0, 'Your Mac runs hot.', left: 62, baseline: 266, fill: PARCHMENT)}
      #{text_at('FiraSans-SemiBold', 58, 0, 'This fixes that.', left: 62, baseline: 334, fill: PARCHMENT)}
      #{text_at('FiraSans-Regular', 22, 0.005, 'A cooler fan curve, Full Blast on demand, and Apple’s defaults one click away.', left: 64, baseline: 384, fill: MUTED)}

      <!-- the live gauge -->
      <ellipse class="glow" cx="#{icon_center_x}" cy="#{icon_center_y}" rx="150" ry="110" fill="url(#heat)"/>
      <rect x="#{plate_left - 3}" y="#{plate_top - 3}" width="#{plate_width + 6}" height="#{plate_height + 6}" rx="#{(plate_height + 6) / 2}" fill="#000" opacity=".35"/>
      <rect x="#{plate_left}" y="#{plate_top}" width="#{plate_width}" height="#{plate_height}" rx="#{plate_height / 2}" fill="url(#face)" stroke="url(#rim)" stroke-width="5"/>
      <rect x="#{plate_left + 9}" y="#{plate_top + 9}" width="#{plate_width - 18}" height="#{plate_height - 18}" rx="#{(plate_height - 18) / 2}" fill="none" stroke="#FFFFFF" stroke-opacity=".07" stroke-width="2"/>

      <g transform="translate(#{icon_center_x} #{icon_center_y}) scale(#{icon_scale})">
        <g class="buck">
          <g class="wisps" fill="none" stroke="#{PARCHMENT}" stroke-opacity=".75" stroke-width=".35" stroke-linecap="round">
            <path class="wisp" transform="translate(5 -6.5)" d="#{Propeller.wisp(7)}"/>
            <path class="wisp" transform="translate(6 3.5)" d="#{Propeller.wisp(6)}"/>
            <path class="wisp" transform="translate(-5 -5.5) scale(-1 1)" d="#{Propeller.wisp(7)}"/>
            <path class="wisp" transform="translate(-6 4.5) scale(-1 1)" d="#{Propeller.wisp(5.5)}"/>
          </g>
          <path class="gear" fill="#B79558" d="#{Propeller.gear}"/>
          <path class="wings" fill="#C9A462" d="#{Propeller.wings}"/>
          <path class="fin" fill="#B79558" d="#{Propeller.fin}"/>
          <path class="body" fill="#8E7444" d="#{Propeller.circle_d(3.6)}"/>
          <path class="blur" fill="#{GOLD}" d="#{Propeller.circle_d(7.4)}"/>
          <g class="spin">
            <path class="blades" fill="url(#brass)" d="#{propeller_blades}"/>
          </g>
          <path fill="#{GOLD}" d="#{hub}"/>
          <path fill="#1A1F2D" d="#{Propeller.circle_d(0.75)}"/>
        </g>
      </g>

      <g clip-path="url(#digits)">
        <g class="roll">
          #{digit_strip}
        </g>
      </g>

      #{text_at('FiraMono-Medium', 14, 0.22, 'LIVE IN YOUR MENU BAR', left: plate_left + plate_width / 2.0, baseline: plate_top + plate_height + 44, fill: MUTED, anchor: :middle)}
    </g>
    <rect x=".75" y=".75" width="1278.5" height="438.5" rx="21.5" fill="none" stroke="#{GOLD}" stroke-opacity=".35" stroke-width="1.5"/>
  </svg>
SVG

File.write(OUT, svg)
puts "#{OUT}: #{File.size(OUT)} bytes"
