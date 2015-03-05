require_relative 'piece.rb'

class SlidingPiece < Piece
  def initialize(board, pos, color)
    super
  end

  def moves
    possible_moves = []

    @move_directions.each do |direction|
      (1..7).each do |mult|
        diff = direction.map{ |el| el * mult }
        try = add_move_diff(diff)

        break unless on_board?(try)
        conflicting_piece = @board[*try]

        if conflicting_piece.nil?
          possible_moves << try
        elsif conflicting_piece.color != color
          possible_moves << try
          break
        else
          break
        end
      end
    end

    possible_moves
  end
end
