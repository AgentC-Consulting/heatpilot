# Ports HeatPilot's PropellerGeometry.swift to SVG path data (y down, origin at the hub).
module Propeller
  BLADE_WIDTH = 1.55
  HUB_RADIUS = 1.7
  FIN_HEIGHT = 8.9
  WING_SPAN = 13.2
  WING_ROOT_Y = -1.6
  WING_TIP_LIFT = 1.6
  GEAR_DROP = 5.0

  module_function

  def f(number)
    format('%.3f', number).sub(/\.?0+$/, '')
  end
  def pt(across, up)
    "#{f(across)} #{f(-up)}"
  end

  def rotate(across, up, angle)
    [across * Math.cos(angle) - up * Math.sin(angle), across * Math.sin(angle) + up * Math.cos(angle)]
  end

  def blade(length, angle = 0)
    w = BLADE_WIDTH
    r = ->(x, y) { pt(*rotate(x, y, angle)) }
    "M#{r[-0.45, 0]}" \
      "C#{r[-0.9, length * 0.25]} #{r[-w, length * 0.45]} #{r[-w, length * 0.62]}" \
      "C#{r[-w, length * 1.08]} #{r[w, length * 1.08]} #{r[w, length * 0.62]}" \
      "C#{r[w, length * 0.45]} #{r[0.9, length * 0.25]} #{r[0.45, 0]}Z"
  end

  def blades(length)
    (0..2).map { |blade_index| blade(length, blade_index * 2 * Math::PI / 3) }.join
  end

  def circle_d(radius)
    "M#{f(-radius)} 0A#{f(radius)} #{f(radius)} 0 1 0 #{f(radius)} 0A#{f(radius)} #{f(radius)} 0 1 0 #{f(-radius)} 0Z"
  end

  def fin
    h = FIN_HEIGHT
    "M#{pt(-1.1, 0)}L#{pt(-0.6, h - 0.6)}Q#{pt(0, h + 0.3)} #{pt(0.6, h - 0.6)}L#{pt(1.1, 0)}Z"
  end

  def wings
    span = WING_SPAN
    lift = WING_TIP_LIFT
    [-1.0, 1.0].map do |s|
      "M#{pt(0, WING_ROOT_Y + 1.25)}L#{pt(s * span, WING_ROOT_Y + lift + 0.55)}" \
        "Q#{pt(s * (span + 0.8), WING_ROOT_Y + lift)} #{pt(s * span, WING_ROOT_Y + lift - 0.55)}" \
        "L#{pt(0, WING_ROOT_Y - 1.25)}Z"
    end.join
  end

  def gear
    [-1.0, 1.0].map do |s|
      x = s * 3.6
      top = WING_ROOT_Y - 0.6
      wy = top - GEAR_DROP
      # strut (rect from wy to top, width .9) and wheel radius 1.15 at wy
      "M#{pt(x - 0.45, top)}L#{pt(x + 0.45, top)}L#{pt(x + 0.45, wy)}L#{pt(x - 0.45, wy)}Z" +
        "M#{pt(x - 1.15, wy)}A1.15 1.15 0 1 0 #{pt(x + 1.15, wy)}A1.15 1.15 0 1 0 #{pt(x - 1.15, wy)}Z"
    end.join
  end

  def wisp(length)
    "M0 0Q#{f(length * 0.5)} 0.6 #{f(length)} -0.5"
  end
end
