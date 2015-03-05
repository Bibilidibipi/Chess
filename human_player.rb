class HumanPlayer
  attr_accessor :color
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def pick_from_pos
    puts "#{@name}, what space would you like to move from? (e.g. a1)"
    pos_conversion(gets.chomp.split(""))
  end

  def pick_to_pos
    puts "#{@name}, what space would you like to move to?"
    pos_conversion(gets.chomp.split(""))
  end

  def pos_conversion(pos)
    if pos[0] =~ /[sql]/
      return pos[0]
    end

    raise InvalidEntry unless pos[0] =~ /[a-h]/ && pos[1] =~ /[1-8]/
    [8 - pos[1].to_i, pos[0].ord - "a".ord]
  end
end
