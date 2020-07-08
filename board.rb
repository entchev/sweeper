require "byebug"

class Board

  def initialize
    @grid = Array.new(9) { Array.new(9, "*") }
    self.place_bombs
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



end