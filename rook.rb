require_relative 'sliding_piece.rb'

class Rook < SlidingPiece

  def initialize(board, pos, color)
    super
    @move_directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def code
    '♜'
  end
end
