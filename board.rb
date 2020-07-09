require_relative "tile.rb"

class Board

  attr_accessor :grid
  

  def initialize
    @grid = Array.new(9) { Array.new(9, "*") }
    self.place_bombs
    self.populate(grid)
  end

  def populate(init_grid)
    @grid = init_grid.map do |row|
      row.map { |value| Tile.new(value) }
    end
  end

  def place_bombs
    counter = 0 
      @grid.each_with_index do |sub, idx1|
          sub.each_with_index do |ele, idx2|
            if rand(6) == 1 && counter < 10
              @grid[idx1][idx2] = "B"
              counter +=1
            end 
          end
      end
  end

  def render_board
    system ("clear")
    puts "  #{(0..8).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
    nil
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


end