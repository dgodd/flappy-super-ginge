# frozen_string_literal: true
require 'ruby2d'
require_relative 'bird'
require_relative 'pipe'

HEIGHT = 640
WIDTH = 420

set width: WIDTH
set height: HEIGHT
set title: 'flappy bird'

def draw_background
  Image.new('./assets/images/flappybirdbg.png', x: 0, y: 0, width: WIDTH, height: HEIGHT)
end

def draw_score(score)
  Text.new(score, x: WIDTH / 2 - 30, y: 120, size: 60, color: 'white', z: 11)
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
