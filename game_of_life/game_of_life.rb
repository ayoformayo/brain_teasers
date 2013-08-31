# This is my implementation of Conway's Game of Life, as described here => http://rubyquiz.strd6.com/quizzes/193-game-of-life
# The rules are simple:
  # Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
  # Any live cell with more than three live neighbours dies, as if by overcrowding.
  # Any live cell with two or three live neighbours lives, unchanged, to the next generation.
  # Any dead cell with exactly three live neighbours becomes a live cell.
# This is the archetypal example of cellular automata.

# My biggest challenge with this problem was building a test framework, 
# as the Game of Life is meant to continue indefinitely.
# To get around this, I ended up creating a parent class GameOfLife 
# which contained the fundamental logic, then adding two subclasses GameOfLifeTest
# and RandomGameOfLife. RandomGameOfLife outputs the game to the console in a (hopefully) aesthetic
# manner, while GameOfLifeTest will return the result of a single iteration of the game, which we can then test against.
# Run the spec suite to see the tests pass, or run 'run_the_game' followed by the size of the grid you want to see.
# The larger the grid, the cooler the patterns!

class GameOfLife
  attr_accessor :board, :length
  def initialize(length)
    @length = length
    @board = []
  end

  def check_board
    brd = @board.clone
    @board.each_with_index do |organism, index|
      neighbours = {alive: 0, dead: 0}
      neighbour_positions = choose_neighbour_set(index)
      neighbour_positions.each do |position|
        neighbours[:alive] += 1 if @board[index+position].strip == "X"
        neighbours[:dead] += 1 if @board[index+position].strip == "."
      end
      # The simple logic behind the game of life. Use strip to account for different input between test input and randomly generated input.
      brd[index] = " . " if organism.strip == "X" && (neighbours[:alive] < 2 || neighbours[:alive] > 3)
      brd[index] = " X " if organism.strip == "." && neighbours[:alive] == 3
    end
    @board = brd
    return @board
  end

  def choose_neighbour_set(index)
    # Determines the set of neighboring positions to check, based on the length of the array and the index of a particular organism.
    # Starts with an array of all possible positions, then whittles that down through a series of if statements.
    if @length > 2
      neighbour_set = [-(@length), -(@length - 1), 1, (@length+1), @length, (@length-1), -1, -(@length + 1)]
      neighbour_set.delete_if{|position| [-(@length + 1), -(@length),-(@length - 1)].include?(position)} if index < @length
      neighbour_set.delete_if{|position| [(@length-1),@length,(@length+1)].include?(position)} if index > ((@length*(@length-1)) -1)
      neighbour_set.delete_if{|position| [-(@length + 1),-1,(@length-1)].include?(position)} if index % @length == 0 || index == 0
      neighbour_set.delete_if{|position| [(@length+1),1,-(@length - 1)].include?(position)} if (index + 1) % @length == 0 && index != 0
      return neighbour_set
    else
      neighbour_set = []
      @board.each_with_index do |cell, i| 
        neighbour_set << i - index if index != i
      end
      return neighbour_set
    end
  end
end


# Game of Life visualizer subclass. The fun one!
class RandomGameOfLife < GameOfLife
  def initialize(size)
    super(size)
    (size*size).times do
      # spaces for better visuals
      @board << [" . "," X "].sample
    end
  end

  def output
    #The game of life will run until it hits the base condition of a 'stable environment', i.e. one that doesn't change between iterations.
    # Perhaps appropriately, a 'stable environment' is rarely found in the game of life, except in the smallest boards.
    while true
      brd = @board.dup
      check_board
      if brd == @board
        return "Stable environment"
      else
        sleep 0.1
        puts "\e[H\e[2J"
        @board.each_slice(@length) {|row| puts row.join("") }
      end
      # if brd == @board
      #   return "Stable environment"
      #   break
      # end
    end
  end
end

# This is the Game of Life testing subclass. It takes a single string, runs a single iteration of the game over it, then returns
# another string we can compare to a hand written response.
class GameOfLifeTest < GameOfLife
  def initialize(str)
   super(Math.sqrt(str.length))
   str.each_char {|c| @board << c}
  end

  def one_iteration
    check_board
    return @board.each{|c| c.strip!}.join("")
  end
end




