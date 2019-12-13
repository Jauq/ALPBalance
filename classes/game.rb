class Game
  attr_accessor :menu, :continue, :actions, :player
  def initialize
    @menu = "main"
    @continue = "main"
    @actions = []
    @player = nil
  end

  def clearScreen
    system("cls")
  end

  def clearActions
    @actions = []
  end

  def newAction(name, dest)
    @actions.push(Action.new(name, dest))
  end

  def setContinue
    @continue = @menu
  end

end
