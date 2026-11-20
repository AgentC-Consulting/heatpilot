# Shared drawing helpers for HeatPilot's README art: brand text as vector outlines
# (from the checksum-verified AgentC fonts) and the two theme palettes.
require_relative 'propeller'

module Kit
  FONTS = File.join(__dir__, '..', 'fonts')
  TEXTPATH = File.join(__dir__, 'textpath')

  GOLD = '#DAB56E'
  DARK = {
    ground: '#23293A', panel: '#2B3245', face_top: '#2E3550', face_bottom: '#1A1F2D',
    accent: '#DAB56E', text: '#ECE7DD', muted: '#A79B86', edge: '#938366', groove: '#171B27', ink: '#23293A'
  }.freeze
  LIGHT = {
    ground: '#F1ECE3', panel: '#FBF8F2', face_top: '#FFFDF8', face_bottom: '#EFE7D8',
    accent: '#8A6A1F', text: '#23293A', muted: '#6F6553', edge: '#B9A988', groove: '#D8CFBF', ink: '#23293A'
  }.freeze

  module_function

  def text_shape(font_name, size, tracking, words)
    output = IO.popen([TEXTPATH, File.join(FONTS, "#{font_name}.ttf"), size.to_s, tracking.to_s, words], &:read)
    width, path_data = output.strip.split("\t", 2)
    [width.to_f, path_data.to_s]
  end

  def text_width(font_name, size, tracking, words)
    text_shape(font_name, size, tracking, words).first
  end

  def text_at(font_name, size, tracking, words, left:, baseline:, fill:, anchor: :start, extra: '')
    width, path_data = text_shape(font_name, size, tracking, words)
    left -= width / 2 if anchor == :middle
    left -= width if anchor == :end
    %(<path transform="translate(#{left.round(2)} #{baseline})" fill="#{fill}" d="#{path_data}"#{extra}/>)
  end

  def brass_gradient(id)
    <<~DEFS
      <radialGradient id="#{id}" cx="0" cy="0" r="8" gradientUnits="userSpaceOnUse">
        <stop offset="0" stop-color="#D2744A"/><stop offset=".45" stop-color="#E0A066"/><stop offset="1" stop-color="#{GOLD}"/>
      </radialGradient>
    DEFS
  end

  def rim_gradient(id)
    <<~DEFS
      <linearGradient id="#{id}" x1="0" x2="0" y1="0" y2="1">
        <stop offset="0" stop-color="#F0D49A"/><stop offset=".5" stop-color="#{GOLD}"/><stop offset="1" stop-color="#8E7444"/>
      </linearGradient>
    DEFS
  end

  def face_gradient(id, palette)
    <<~DEFS
      <linearGradient id="#{id}" x1="0" x2="0" y1="0" y2="1">
        <stop offset="0" stop-color="#{palette[:face_top]}"/><stop offset="1" stop-color="#{palette[:face_bottom]}"/>
      </linearGradient>
    DEFS
  end

  # A still propeller mark centered at (center_x, center_y).
  def propeller_mark(center_x, center_y, scale, fill, hole_fill)
    %(<g transform="translate(#{center_x} #{center_y}) scale(#{scale})"><path fill="#{fill}" d="#{Propeller.blades(7.6)}"/>) +
      %(<path fill="#{hole_fill}" d="#{Propeller.circle_d(1.0)}"/></g>)
  end

  def svg_open(width, height, title, description)
    %(<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 #{width} #{height}" width="#{width}" height="#{height}" role="img" aria-labelledby="t d">) +
      %(<title id="t">#{title}</title><desc id="d">#{description}</desc>)
  end
end
