require_relative "board.rb"
require_relative "tile.rb"

class Sweeper

  def initialize 
    @board = Board.new
  end

  def run
    play_turn until game_over?
  end

  def valid_selection?(selection)
    true if selection == 1 || selection == 2
  end

  def valid_position?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, 8) }
  end

  def player_selection
    selection = nil
    until valid_selection?(selection)
      puts "Make a selection: Type 1 to reveal a tile"
      puts "or 2 to place a flag (marking a potential bomb)" 
      selection = gets.chomp.to_i
    end
    selection
  end

  def play_turn
    board.render_board
    puts
    puts "Welcome to Minesweeper 2.0! Copyright Denis Entchev."
    sleep(2)
    board.render_board
    puts
    selection = self.player_selection
    self.place_flag if selection == 2
    self.reveal_tile if selection == 1 
  end

  def game_over?
  end

  def place_flag
    pos = nil
    board.render_board
    puts
    until pos && valid_position?(pos)  
      puts "Please enter a position on the field (e.g., '3,4'"
      print "> "
      pos = parse_pos(gets.chomp)
    end
    puts "Accepted!"
    sleep(2)
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
    puts "Accepted!"
    sleep(2)
  end

  private

  attr_reader :board

end