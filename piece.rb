require 'byebug'

class Piece
  attr_accessor :pos
  attr_writer :board
  attr_reader :color

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def valid_moves
    moves.select { |move| !move_into_check?(move) }
  end

  def render
    display_color = (@color == :white ? :red : :blue)
    ' ' + code.colorize(display_color) + '  '
  end

  def on_board?(position)
    position.all? { |coord| (0..7).include?(coord) }
  end

  def add_move_diff(diff)
    diff.zip(pos).map{ |a| a[0] + a[1] }
  end

  def move_into_check?(end_pos)
    board_dup = @board.deep_dup

    board_dup.move!(@pos, end_pos)
    board_dup.in_check?(@color)
  end

  def inspect
    "Type: #{self.class}, Pos: #{@pos}, Color: #{@color}"
  end
end
