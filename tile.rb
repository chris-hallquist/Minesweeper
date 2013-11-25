class Tile
  attr_accessor :bombed, :flagged, :revealed, :neighbors

  def initialize
    @bombed = false
    @flagged = false
    @revealed = false
    @neighbors = []
  end

  def reveal
  end

  def neighbor_bomb_count
  end
end
