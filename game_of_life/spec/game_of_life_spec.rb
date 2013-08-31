require 'spec_helper'


describe GameOfLifeTest do
  before :each do
    @game = GameOfLifeTest.new("XX.XXX...X.XXX..X..XX...X..XX.X..X.....X.XXX.XXX..XXX.XXX.XX.XXX.XXX..X..X.XX.XX.")
    @game2 = GameOfLifeTest.new('X..XX..X.')
    @game3 = GameOfLifeTest.new("..X..X.XXX..X..X")
    @game4 = GameOfLifeTest.new("XXX...XXX")
    @game5 = GameOfLifeTest.new(".XXX")
    @game6 = GameOfLifeTest.new("X.XX")
  end

  describe "#new" do
    it 'returns a GameOfLifeTest object' do
      @game.should be_an_instance_of GameOfLifeTest
    end
  end
  describe "#one_iteration" do
    it 'returns the correct string' do
      @game.one_iteration.should eq("XX...X...X.....X......XXXX.XX.XX.......X.....X................XX.........X..XXXX.")
      @game2.one_iteration.should eq("XX.XX.XX.")
      @game3.one_iteration.should eq("..X.XX..XX..XX..")
      @game4.one_iteration.should eq(".X.....X.")
      @game5.one_iteration.should eq("XXXX")
      @game6.one_iteration.should eq("XXXX")

    end
  end
end

describe RandomGameOfLife do
  before :each do
    @game = RandomGameOfLife.new(9)
    @game2 = RandomGameOfLife.new(2)
    @game2.board = [".",".",".","."]
  end
  describe "#new" do
    it 'returns a RandomGameOfLife object' do
      @game.should be_an_instance_of RandomGameOfLife
    end
    it 'has a board length the square of the input' do
      @game.board.length.should eq(81)
    end
  end
  describe "#output" do
    it "returns the board when frozen" do
      @game2.output.should eq("Stable environment")
    end
  end
end

describe GameOfLife do
  before :each do
    @game = GameOfLife.new(3) 
  end

  describe "#choose_neighbour_set" do
    it 'returns the neighbours of an organism on the board' do
      @game.choose_neighbour_set(0).sort.should eq([1,3,4])
    end
  end
end
