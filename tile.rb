class Tile
  DELTAS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ].freeze

  attr_reader :bomb, :flagged, :revealed, :pos
  
  def initialize(board, pos)
    @board, @pos = board, pos
    @bomb, @flagged, @revealed = false, false ,false
  end

  def neighbors
    adjacent_coords = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |coord|
        coord.between?(0, 8)
      end
    end

    adjacent_coords.map { |pos| @board[pos] }
  end

  def adjacent_bomb_count
    neighbors.select(&:bomb).count
  end

  def reveal
    # used to fully reveal the board at game end
    if flagged
      # mark true and false flags
      bomb ? "F" : "f"
    elsif bomb
      # display a hit bomb as an X
      revealed ? "X" : "B"
    else
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    end
  end

  def explore
    # don't explore a location user thinks is bombed.
    return self if flagged

    # don't revisit previously explored tiles
    return self if revealed

    @revealed = true
    if !bomb && adjacent_bomb_count == 0
      neighbors.each(&:explore)
    end

    self
  end

  def render
    if flagged
      "F"
    elsif revealed
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    else
      "*"
    end
  end

  def toggle_flag
    @flagged = !@flagged unless @revelead
  end

  def to_s
    return "F" if @flagged
    @revealed ? @value : "*"
  end

  def inspect
    # don't show me the whole board when inspecting a Tile; that's
    # information overload.
    { pos: pos,
      bombed: bombed,
      flagged: flagged,
      revealed: revealed }.inspect
  end

  def plant_bomb
    @bomb = true
  end

end