require_relative "tile"

class Board

  attr_reader :grid
  
  def initialize
    @grid = Array.new(9) do |row|
      Array.new(9) { |col| Tile.new(self, [row, col]) }
    end
    self.place_bombs
  end

  def reveal
    render_board(true)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    tile = grid[row][col]
    tile.value = value
  end

  def won?
    @grid.flatten.all? { |tile| tile.bomb != tile.revealed }
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bomb && tile.revealed }
  end

  def render_board(reveal = false)
    temp_grid = @grid.map do |row|
      row.map do |tile|
        reveal ? tile.reveal : tile.render
      end
    end

    system ("clear")
    puts "  #{(0..8).to_a.join(' ')}"
    temp_grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
    nil
  end

  def place_bombs
    total_bombs = 0
    while total_bombs < 10
      rand_pos = Array.new(2) { rand(9) }

      tile = self[rand_pos]
      next if tile.bomb

      tile.plant_bomb
      total_bombs += 1
    end

    nil
  end

end