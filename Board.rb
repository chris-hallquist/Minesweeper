require_relative 'Tile'

class Board

  DIFFS = [[-1, -1],
           [-1, 0],
           [-1, 1],
           [0, -1],
           [0, 1],
           [1, -1],
           [1, 0],
           [1, 1]]

  attr_accessor :tiles

  def initialize
    @tiles = Array.new(9) { Array.new(9) { Tile.new } }
    populate_neighbors
    mine_board
  end

  def populate_neighbors
    @tiles.each_index do |row|
      @tiles[row].each_with_index do |tile, column|
        neighbors_coords(row, column).each do |coords|
          tile.neighbors << @tiles[row][column]
        end
      end
    end
  end

  def neighbors_coords(x,y)
    neighbors = []

    DIFFS.each do |coord|
      neighbors << [x + coord.first, y + coord.last]
    end

    neighbors
  end

  def mine_board
    mines_to_place = 10
    until mines_to_place == 0
      tile = @tiles.sample.sample
      next if tile.bombed
      tile.bombed = true
      mines_to_place -= 1
    end
  end

  def display
    @tiles.each do |row|
      row.each do |tile|
        if tile.flagged
          print "F "
        elsif !tile.revealed
          print "* "
        else
          print "_ "
        end
      end
      puts
    end
  end
end

def test
  board = Board.new
end