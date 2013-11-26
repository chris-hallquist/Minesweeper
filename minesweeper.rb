require_relative 'Board'

class Minesweeper
  # NUM_TILES =
  # NUM_BOMBS =
  def initialize
    @board = Board.new
  end

  def save(filename)
    File.open(filename, "w")
  end

  def load
  end

  def play
    until game_won?
      # puts @board
      @board.display
      input = get_user_input
      output = process_input(input)
      if output == :bomb
        puts "Bomb! You lose!"
        break
      elsif output == :flagged
        puts "I'm sorry Dave, I can't do that. This tile is flagged."
      end
    end
    puts "You win!" if game_won?
  end

  def game_won?
    # @board.game_won?
    revealed_count = 0
    @board.tiles.each do |row|
      row.each do |tile|
        revealed_count += 1 if tile.revealed
      end
    end
    revealed_count == 71
  end

  def get_user_input
    puts "Type the coordenates in the format \"row, column\" separated by comma"
    row, column = gets.chomp.split(",").map(&:to_i)
    puts "Followed by R for reveal or F for flag."
    option = gets.chomp.downcase

    return [row,column,option]
  end

  def process_input(input)
    row, column = input[0], input[1]
    option = input[2]
    reveal_output = true

    if option == "f"
      # @board.flag(row, col)
      @board.tiles[row][column].flagged = !@board.tiles[row][column].flagged
    else
      # @board.reveal(row, col)
      reveal_output = @board.tiles[row][column].reveal(@board)
    end
    reveal_output
  end

end