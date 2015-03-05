require_relative 'sliding_piece.rb'

class Bishop < SlidingPiece
  def initialize(board, pos, color)
    super
    @move_directions = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  def code
    '♝'
  end
end
