# frozen_string_literal: true

class Bird
  attr_reader :x, :y
  attr_writer :gravity, :velocity

  def initialize
    @width = 36 * 2
    @height = 33 * 2
    reset
  end

  def reset
    @x = 30
    @y = HEIGHT / 2
    @gravity = 0.7
    @velocity = 0
  end

  def draw
    Image.new('./assets/images/ginge.png', x: @x, y: @y, width: @width, height: @height, z: 10)
  end

  def move
    @velocity += @gravity
    @y = [@y + @velocity, 0].max
  end

  def felt?
    @y >= HEIGHT
  end

  def jump
    @velocity = -8
  end
end
