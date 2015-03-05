require_relative 'piece.rb'

class SteppingPiece < Piece

  def initialize(board, pos, color)
    super
  end

  def moves
    possible_moves = []

    @move_diffs.each do |diff|
      try = add_move_diff(diff)

      next unless on_board?(try)
      conflicting_piece = @board[*try]

      if conflicting_piece.nil? || conflicting_piece.color != color
        possible_moves << try
      end
    end

    possible_moves
  end
end
