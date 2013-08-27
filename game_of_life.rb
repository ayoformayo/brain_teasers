class Game_of_life
  attr_accessor :board
  def initialize
    @board = []
    81.times do
      @board << [0,1].sample
    end
    @board.each_slice(9) {|row| p row }
    check_board
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
      @board[index],message = 0, "Changed to zero" if organism == 1 && (neighbours[:alive] < 2 || neighbours[:alive] > 3)
      @board[index], message = 1, "Changed to one" if organism == 0 && neighbours[:alive] == 3
      puts "\e[H\e[2J"
      @board.each_slice(9) {|row| p row }
      p index
      if message != ""
        p message
        sleep 10
      else 
        sleep 0.1
      end
      # p message+ "#{index}- #{organism} neighbours: #{neighbours}"
    end
    check_board
  end

  def choose_neighbour_set(index)
    neighbour_set = [-9, -8, 1, 10, 9, 8, -1, -10]
    neighbour_set.delete_if{|position| (-10..-8).include?(position)} if index < 9
    neighbour_set.delete_if{|position| (10..8).include?(position)} if index < 72
    neighbour_set.delete_if{|position| [-10,-1,8].include?(position)} if index % 9 == 0 || index == 0
    neighbour_set.delete_if{|position| [10,1,-8].include?(position)} if index % 8 == 0 && index != 0
    return neighbour_set
  end



end

Game_of_life.new
