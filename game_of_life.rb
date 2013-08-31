class Game_of_life
  def initialize(str="")
    @test = nil
    @board = []
    if str != ""
      str.each_char {|c| @board << c.to_i}
      @test = true
    else
      81.times do
        @board << [0,1].sample
      end
    end
  end

  def check_board
  
    @board.each_with_index do |organism, index|
      neighbours = {alive: 0, dead: 0}
      neighbour_positions = choose_neighbour_set(index)
      neighbour_positions.each do |position|
        neighbours[:alive] += 1 if @board[index+position] == 1
        neighbours[:dead] += 1 if @board[index+position] == 0
      end
      message = ""
      @board[index] = 0 if organism == 1 && (neighbours[:alive] < 2 || neighbours[:alive] > 3)
      @board[index] = 1 if organism == 0 && neighbours[:alive] == 3
    end
    if @test
      return @board.join("")
    else
      sleep 0.5
      puts "\e[H\e[2J"
      @board.each_slice(9) {|row| p row }
      check_board
    end
  end

  def choose_neighbour_set(index)
    neighbour_set = [-9, -8, 1, 10, 9, 8, -1, -10]
    neighbour_set.delete_if{|position| [-10, -9,-8].include?(position)} if index < 9
    neighbour_set.delete_if{|position| [8,9,10].include?(position)} if index > 71
    neighbour_set.delete_if{|position| [-10,-1,8].include?(position)} if index % 9 == 0 || index == 0
    neighbour_set.delete_if{|position| [10,1,-8].include?(position)} if (index + 1) % 9 == 0 && index != 0
    return neighbour_set
  end
end


# Uncomment to watch the game of life unfold!
# Game_of_life.new.check_board


# >>>>>>>>>>>>>>>>>>>>> Driver code

# Test string one
arr = "100100111110100011110110001100110010000010111101100010010111110110111100110000011"
game = Game_of_life.new(arr) 
p game.check_board == "110000101000111101110000101111110001100011101101000000000000110111111001101011111"

# test string two
arr2 = "110111000101110010011000100110100100000101110111001110111011011101110010010110110"
game2 = Game_of_life.new(arr2)
p game2.check_board == "110011000100110110001010100001010010000100011101001000101001011100010001000111110"

