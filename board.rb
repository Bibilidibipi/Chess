require_relative 'require_all_pieces.rb'
require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    init_state
    @white_captured = []
    @black_captured = []
  end

  def move(start_pos, end_pos)
    piece = self[*start_pos]

    raise MoveImpossible unless piece.moves.include?(end_pos)
    raise CheckError unless piece.valid_moves.include?(end_pos)

    unless self[*end_pos].nil?
      captured = self[*end_pos]
      captured.color == :white ?
        @white_captured << captured.code.colorize(:red) :
        @black_captured << captured.code.colorize(:blue)
    end

    self[*end_pos] = piece
    piece.pos = end_pos
    self[*start_pos] = nil
  end

  def move!(start_pos, end_pos)
    piece = self[*start_pos]
    self[*end_pos] = piece
    piece.pos = end_pos
    self[*start_pos] = nil
  end

  def in_check?(color)
    king = pieces_of_color(color).find { |piece| piece.class == King }

    pieces_of_color(other_color(color)).each do |piece|
      return true if piece.moves.include?(king.pos)
    end

    false
  end

  def checkmate?(color)
    pieces_of_color(color).none? do |piece|
      piece.valid_moves.any?
    end
  end

  def [](x, y)
    @grid[x][y]
  end

  def []=(x, y, resident)
    @grid[x][y] = resident
  end

  def display
    puts to_s
  end

  def deep_dup
    board_dup = self.dup

    board_dup.grid = @grid.dup
    @grid.each_with_index do |row, i|
      board_dup.grid[i] = row.dup
      row.each_with_index do |square, j|
        if square
          board_dup[i,j] = square.dup
          board_dup[i,j].board = board_dup
        end
      end
    end

    board_dup
  end

  def all_pieces
    @grid.flatten.compact
  end

  private

  def pieces_of_color(color)
    @grid.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def other_color(color)
    color == :white ? :black : :white
  end

  def to_s
    to_show = ""
    to_show += letters

    @grid.each_with_index do |row, i|
      to_show << "#{8 - i} "
      row.each_with_index do |square, j|
        background_color = ((i + j).odd? ? :black : :light_black)
        square_str = square.nil? ? '    ' : square.render
        to_show << (square_str.colorize(background: background_color))
      end
      to_show << " #{8 - i}"
      to_show << "  #{@white_captured.join(' ')}" if i == 0
      to_show << "  #{@black_captured.join(' ')}" if i == 7
      to_show << "\n"
    end

    to_show += letters
  end

  def letters
    "   " + ("a".."h").to_a.join("   ") + "\n"
  end

  def init_state
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    back_row.each_with_index do |piece_class, i|
      self[0, i] = piece_class.new(self, [0, i], :black)
    end

    back_row.each_with_index do |piece_class, i|
      self[7, i] = piece_class.new(self, [7, i], :white)
    end

    (0..7).each do | i|
      self[1, i] = Pawn.new(self, [1, i], :black)
    end

    (0..7).each do | i|
      self[6, i] = Pawn.new(self, [6, i], :white)
    end
  end
end
