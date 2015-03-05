class OutOfBounds < RuntimeError
  def initialize(msg = "That space is not on the board")
    super(msg)
  end
end

class MoveImpossible < RuntimeError
  def initialize(msg = "That move is illegal")
    super(msg)
  end
end

class CheckError < RuntimeError
  def initialize(msg = "You can't move into check")
    super(msg)
  end
end

class StartPosError < RuntimeError
  def initialize(msg = "You don't have a piece there")
    super(msg)
  end
end

class InvalidEntry < RuntimeError
  def initialize(msg = "Enter space as letter followed by number")
    super(msg)
  end
end

class GameSaveError < RuntimeError
  def initialize(msg = "Game saved.")
    super(msg)
  end
end
