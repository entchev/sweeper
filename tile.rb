require_relative "board.rb"

class Tile
  attr_accessor :value, :bomb, :flagged, :revealed
  
  def initialize(value)
    @value = value
    @bomb = value == "B" ? true : false
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def neighbors(tile)
  end

  def flag
    @flagged = true
  end

  def neighbor_bomb_count(tile)
  end

  def to_s
    return "F" if @flagged
    @revealed ? @value : "*"
  end

  def inspect
    self.value.inspect
  end

  def value=(new_value)
      @value = new_value
  end

  def revealed=
    @revealed = true
  end

  def flagged= 
    @flagged = true
  end


end