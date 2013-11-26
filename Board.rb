require_relative 'Tile.rb'
require 'debugger'

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
    mine_board
    populate_neighbors
  end

  def populate_neighbors
    (0..8).each do |row|
      (0..8).each do |column|

        neighbors = neighbors_coords(row, column)

        neighbors.each do |coords|
          @tiles[row][column].neighbors << coords
        end
      end
    end
  end

  def neighbors_coords(x,y)
    neighbors = []

    DIFFS.each do |coord|
      _x = x + coord.first
      _y = y + coord.last
      neighbors << [_x,_y] unless _x < 0 || _y < 0 || _x > 8 || _y > 8
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

  def _display
    @tiles.each do |row|
      row.each do |tile|
        if tile.bombed && !tile.revealed
          print "* "
        elsif !tile.revealed
          print "+ "
        else
          print "_ "
        end
      end
      puts
    end
  end

  def display
    @tiles.each do |row|
      row.each do |tile|
        if tile.flagged
          print "F "
        elsif tile.revealed && tile.neighbor_bomb_count(self) > 0
          print "#{tile.neighbor_bomb_count(self)} "
        elsif tile.revealed
          print "_ "
        else
          print "* "
        end
      end
      puts
    end
  end
end