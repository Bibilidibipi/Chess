require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'error_classes.rb'
require 'yaml'


class Game
  def initialize(white, black)
    @white = white
    @white.color = :white
    @black = black
    @black.color = :black
    @current_player = white
    @board = Board.new
  end

  def play
    puts "It's on! Place your bets now."
    puts "Enter q to quit, s to save, "\
         "or l to load at the beginning of any turn"

    until won?
      @board.display
      make_move
      switch_player
    end

    @board.display
    puts "#{@current_player.name} is in checkmate."
    switch_player
    puts "#{@current_player.name} wins!!"
  end

  private

  def make_move
    start_pos = get_from_pos
    end_pos = get_to_pos
    @board.move(start_pos, end_pos)

    rescue MoveImpossible, CheckError => e
      puts e.message
      retry
  end

  def get_from_pos
    begin
      start_pos = @current_player.pick_from_pos
      while start_pos =~ /[sql]/
        start_pos = handle_and_reask(start_pos)
      end
      check_start_pos(start_pos, @current_player.color)
    rescue InvalidEntry, StartPosError, GameSaveError => e
      puts e.message
      retry
    end

    start_pos
  end

  def handle_and_reask(request)
    case request
    when 's'
      save
    when 'q'
      quit
    when 'l'
      load_game
    end

    @current_player.pick_from_pos
  end

  def get_to_pos
    begin
      end_pos = @current_player.pick_to_pos
    rescue InvalidEntry => e
      puts e.message
      retry
    end

    end_pos
  end

  def check_start_pos(start_pos, color)
    piece = @board[*start_pos]
    raise StartPosError if piece.nil? || piece.color != color
  end

  def won?
    [:white, :black].any?{ |col| @board.checkmate?(col) }
  end

  def switch_player
    @current_player = (@current_player == @white ? @black : @white)
  end

  def save
    File.open('saved_game.yml', 'w') { |f| f.puts self.to_yaml }
  end

  def quit
    puts "Are you sure? (Y/N)"
    confirmation = gets.chomp.upcase
    exit if confirmation == 'Y'
  end

  def load_game
    puts "Are you sure? (Y/N)"
    confirmation = gets.chomp.upcase
    puts "Are you sure? (Y/N)"
    if confirmation == 'Y'
      YAML.load_file('saved_game.yml').play
      exit
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  T = HumanPlayer.new("Tripp")
  J = HumanPlayer.new("Judy")
  game = Game.new(T, J)
  game.play
end
