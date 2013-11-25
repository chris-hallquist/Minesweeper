class Tile
  attr_accessor :bombed, :flagged, :revealed, :neighbors, :count_cache

  def initialize
    @bombed = false
    @flagged = false
    @revealed = false
    @neighbors = []
    @count_cache = nil
  end

  def reveal
    return :flagged if @flagged
    @revealed = true
    return :bomb if @bombed
    return neighbor_bomb_count
  end

  def neighbor_bomb_count(neighbors)
    unless @count_cache
      @count_cache = neighbors.inject(0) do |acumulator, neighbor|
        acumulator + 1 if neighbor.bombed
      end
      @count_cache ||= 0
    end
    @count_cache
  end
end