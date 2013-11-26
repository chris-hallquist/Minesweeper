

class Tile
  attr_accessor :bombed, :flagged, :revealed, :neighbors, :count_cache

  def initialize
    @bombed = false
    @flagged = false
    @revealed = false
    @neighbors = []
    @count_cache = nil
  end

  def reveal(board)
    return :flagged if @flagged
    @revealed = true
    return :bomb if @bombed
    if neighbor_bomb_count(board) == 0
      @neighbors.each do |coords|
        tile = board.tiles[coords[0]][coords[1]]
        tile.reveal(board) unless tile.revealed
      end
    end
  end

  def neighbor_bomb_count(board)
    unless @count_cache
      @count_cache = neighbors.inject(0) do |acumulator, neighbor|
        if board.tiles[neighbor[0]][neighbor[1]].bombed
          acumulator + 1
        else
          acumulator
        end
      end
      @count_cache ||= 0
    end
    @count_cache
  end
end