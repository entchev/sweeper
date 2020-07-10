require_relative "board"
require_relative "tile"

class Sweeper

  def initialize 
    @board = Board.new
  end

  def run
    until @board.won? || @board.lost?
      puts board.render_board
      self.play_turn
    end
    
    if @board.won?
      puts "**You win! Congratulations!**"
    elsif @board.lost?
      puts @board.reveal
      puts "**Bomb hit! You lost!**"
    end
    
  end

  def valid_selection?(selection)
    true if selection == 1 || selection == 2 || selection == 3
  end

  def valid_position?(pos)
    pos.is_a?(Array) &&
      board[pos].revealed == false &&
      board[pos].flagged == false &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, 8) }
  end

  def player_selection
    selection = nil
    until valid_selection?(selection)
      puts "Make a selection: Type 1 to reveal a tile,"
      puts "2 to place a flag (marking a potential bomb)"
      puts "or 3 to remove a flag if you need to"  
      selection = gets.chomp.to_i
    end
    selection
  end

  def play_turn
    puts board.render_board
    puts
    puts "Welcome to Minesweeper 2.0! Copyright Denis Entchev."
    sleep(1)
    puts board.render_board
    puts
    selection = self.player_selection
    self.place_flag if selection == 2
    self.reveal_tile if selection == 1
    self.remove_flag if selection == 3 
  end

  def place_flag
    pos = nil
    puts board.render_board
    puts
    until pos && valid_position?(pos)  
      puts "Please enter a position on the field to place the flag (e.g., '3,4'"
      print "> "
      pos = parse_pos(gets.chomp)
    end
    board[pos].toggle_flag
  end

  def remove_flag
    pos = nil
    puts board.render_board
    puts
    until pos && board[pos].flagged == true  
      puts "Please enter a position on the field for the flag to be removed (e.g., '3,4'"
      print "> "
      pos = parse_pos(gets.chomp)
    end
    board[pos].toggle_flag
  end


  def parse_pos(string)
    string.split(",").map { |char| Integer(char) }
  end

  def reveal_tile
    pos = nil
    board.render_board
    puts
    until pos && valid_position?(pos) 
      puts "Please enter a position on the field (e.g., '3,4'"
      print "> "
      pos = parse_pos(gets.chomp)
    end
    board[pos].explore
  end

  attr_reader :board

end

if $PROGRAM_NAME == __FILE__
  Sweeper.new.run
end