# This is my implementation of Conway's Game of Life, as described here => http://rubyquiz.strd6.com/quizzes/193-game-of-life
# The rules are simple:
  # Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
  # Any live cell with more than three live neighbours dies, as if by overcrowding.
  # Any live cell with two or three live neighbours lives, unchanged, to the next generation.
  # Any dead cell with exactly three live neighbours becomes a live cell.
# This is the archetype of cellular automata.

# My biggest challenge with this problem was building a test framework, as the Game of Life is meant to continue indefinetly.
# To get around this, I ended up created a parent class GameOfLife, and two subclasses GameOfLifeTest and RandomGameOfLife.


class GameOfLife
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
        neighbours[:alive] += 1 if @board[index+position] == 1
        neighbours[:dead] += 1 if @board[index+position] == 0
      end
      brd[index] = 0 if organism == 1 && (neighbours[:alive] < 2 || neighbours[:alive] > 3)
      brd[index] = 1 if organism == 0 && neighbours[:alive] == 3
    end
    @board = brd
    return @board
  end

  def choose_neighbour_set(index)
    neighbour_set = [-(@length), -(@length - 1), 1, (@length+1), @length, (@length-1), -1, -(@length + 1)]
    neighbour_set.delete_if{|position| [-(@length + 1), -(@length),-(@length - 1)].include?(position)} if index < @length
    neighbour_set.delete_if{|position| [(@length-1),@length,(@length+1)].include?(position)} if index > ((@length*(@length-1)) -1)
    neighbour_set.delete_if{|position| [-(@length + 1),-1,(@length-1)].include?(position)} if index % @length == 0 || index == 0
    neighbour_set.delete_if{|position| [(@length+1),1,-(@length - 1)].include?(position)} if (index + 1) % @length == 0 && index != 0
    return neighbour_set
  end
end


class RandomGameOfLife < GameOfLife
  def initialize(size)
    super(size)
    (size*size).times do
      @board << [0,1].sample
    end
  end

  def output
    while true # Iterate till ^C?
      check_board
      sleep 0.5
      puts "\e[H\e[2J"
      @board.each_slice(@length) {|row| p row }
    end
  end
end

class GameOfLifeTest < GameOfLife
  def initialize(str)
   super(Math.sqrt(str.length))
   str.each_char {|c| @board << c.to_i}
  end

  def one_iteration
    check_board
    return @board.join("")
  end
end
# Uncomment to watch the game of life unfold!
RandomGameOfLife.new(30).output


# >>>>>>>>>>>>>>>>>>>>> Driver code

# Test string one
# arr = "100100111110100011110110001100110010000010111101100010010111110110111100110000011"
# game = GameOfLifeTest.new(arr) 
# p game.one_iteration == "110000101000111101110000101111110001100011101101000000000000110111111001101011111"

# # test string two
arr2 = "110111000101110010011000100110100100000101110111001110111011011101110010010110110"
game2 = GameOfLifeTest.new(arr2)
p game2.one_iteration == "110001000100000100000011110110110000000100000100000000000000001100000000010011110"
# p game2.one_iteration == "110011000100110110001010100001010010000100011101001000101001011100010001000111110"


# test string three
arr3 ='100110010'
game3 = GameOfLifeTest.new(arr3)
# p game3.one_iteration == "110011011"
p game3.one_iteration == "110110110"


# test string four

arr4 = "0010010111001001"
game4 = GameOfLifeTest.new(arr4)
p game4.one_iteration == "0010110011001100"




