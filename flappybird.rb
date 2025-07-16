# frozen_string_literal: true
require 'ruby2d'

HEIGHT = 640
WIDTH = 420

set width: WIDTH
set height: HEIGHT
set title: 'flappy bird'

class Bird
  def initialize
    @x = 30
    @y = HEIGHT / 2
    @width = 36
    @height = 33
    @gravity = 0.7
    @velocity = 0
  end

  def draw
    Image.new('./assets/images/flappybird.png', x: @x, y: @y, width: @width, height: @height, z: 10)
  end

  def move
    @velocity += @gravity
    @y = [@y + @velocity, 0].max
  end

  def jump
    @velocity = -8
  end
end

def draw_background
  Image.new('./assets/images/flappybirdbg.png', x: 0, y: 0, width: WIDTH, height: HEIGHT)
end
def draw_score(score)
  Text.new(score, x: WIDTH / 2 - 30, y: 120, size: 60, color: 'white', z: 11)
end
bird = Bird.new

class Pipe
  def initialize
    @width = 55
    @height = 512/4 + rand(512/2)
    @x = WIDTH + @width
    @y = 0
    @open_gap = HEIGHT / 4
    @moving_distance = 7
  end

  def move
    @x -= @moving_distance
  end
  def out_of_scope?
     @x + @width <= 0
   end
  def draw
    Image.new('./assets/images/toppipe.png',
    x: @x,
    y: @y,
    width: @width,
    height: @height,
    z: 10)

    Image.new('./assets/images/bottompipe.png',
    x: @x,
    y: @height + @open_gap,
    width: @width,
    height: HEIGHT - @height,
    z: 10)
  end
end

bird = Bird.new
pipes = []
pipes << Pipe.new

update do
  clear
  draw_background
  bird.draw
  bird.move

  pipes.each do |pipe|
    pipe.draw
    pipe.move
  end

  pipes << Pipe.new if Window.frames % 60 == 0
  pipes.shift if pipes.first.out_of_scope?
end

on :key_up do |event|
  bird.jump if event.key == 'space'
end

show
