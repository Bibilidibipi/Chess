require_relative 'stepping_piece.rb'

class King < SteppingPiece

  def initialize(board, pos, color)
    super
    @move_diffs = [
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
      [0, -1],
      [1, -1]
    ]
  end

  def code
    '♚'
  end
end
