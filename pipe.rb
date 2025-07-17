class Pipe
  attr_writer :scored, :moving_distance


  def initialize
    @width = 55
    @height = 512/4 + rand(512/2)
    @x = WIDTH + @width
    @y = 0
    @open_gap = HEIGHT / 4
    @moving_distance = 5
  end

  def hit?(x,y)
      (@x..@x + @width).include?(x) && ((0..@height).include?(y) || (@height+@open_gap..HEIGHT).include?(y))
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

  def move
    @x -= @moving_distance
  end

  def out_of_scope?
    @x + @width <= 0
  end

  def score?
    passed? && !@scored
  end

  private
  def passed?
    @x <= 30
  end
end
