# frozen_string_literal: true

class Bubble
  def initialize(x: 30, y: HEIGHT, velocity: -10)
    @width = 497 / 3
    @height = 502 / 3
    @velocity = velocity
    @x = x
    @y = y
  end

  def draw
    Image.new('./assets/images/bubbles.png', x: @x, y: @y, width: @width, height: @height, z: 20)
  end

  def move
    @y = [@y + @velocity, 0].max
  end
end
