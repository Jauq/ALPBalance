class Game
  attr_accessor :menu, :actions
  def initialize
    @menu = "main"
    @actions = []
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

end
