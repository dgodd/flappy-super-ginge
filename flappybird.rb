# frozen_string_literal: true
require 'ruby2d'
require 'pry'

require_relative 'bird'
require_relative 'pipe'

HEIGHT = 640
WIDTH = 420

set width: WIDTH
set height: HEIGHT
set title: 'flappy bird'

def draw_game_over
  txt = Text.new("I ROCK", y: HEIGHT/2, size: 30, color: 'red', z: 11)
  txt.x = WIDTH/2 - txt.width/2
  txt
end

def draw_background
  Image.new('./assets/images/flappybirdbg.png', x: 0, y: 0, width: WIDTH, height: HEIGHT)
end

def draw_score(score)
  Text.new(score, x: WIDTH / 2 - 30, y: 120, size: 60, color: 'white', z: 11)
end

bird = Bird.new
pipes = []
pipes << Pipe.new
game_over = false # new game_over flag variable
score = 0

update do
  clear
  draw_background
  draw_score(score)
  bird.draw
  bird.move

  pipes.each do |pipe|
    pipe.draw
    pipe.move
  end

  if game_over # 1
    draw_game_over
    next
  end

  pipes << Pipe.new if Window.frames % 40 == 0

  if pipes.first.score?
    pipes.first.scored = true
    score += 1
  end

  pipes.shift if pipes.first.out_of_scope?

  if bird.felt? || pipes.first.hit?(bird.x, bird.y)
    game_over = true
    pipes.each { |pipe| pipe.moving_distance = 0}
    bird.gravity = 0
    bird.velocity = 0
  end
end

on :key_up do |event|
  bird.jump if event.key == 'space' && !game_over
end

show
