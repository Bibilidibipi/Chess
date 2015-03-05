require_relative 'piece.rb'

class Pawn < Piece
  def initialize(board, pos, color)
    super
    @initial_pos = pos
  end

  def moves
    dir_mul = (@color == :white ? -1 : 1)

    forward_moves(dir_mul) + capture_moves(dir_mul)
  end

  def forward_moves(dir_mul)
    for_moves = []

    try = add_move_diff([1 * dir_mul, 0])
    if @board[*try].nil?
      for_moves << try
      try = add_move_diff([2 * dir_mul, 0])
      if @board[*try].nil? && @initial_pos == @pos
        for_moves << try
      end
    end

    for_moves
  end

  def capture_moves(dir_mul)
    cap_moves = []

    try_captures = [[1 * dir_mul, 1], [1 * dir_mul, -1]]
    try_captures.each do |diff|
      try = add_move_diff(diff)
      cap_moves << try if @board[*try] && @board[*try].color != @color
    end

    cap_moves
  end

  def code
    '♟'
  end
end
