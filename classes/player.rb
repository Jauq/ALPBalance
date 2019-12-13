class Player
  attr_accessor :name, :mhp, :chp, :malp, :base, :atk, :def
  def initialize
    @name = "Yakov"
    @mhp = 20
    @chp = 20
    @malp = 12
    @base = [4, 4, 4]
    @atk = [0, 0, 0]
    @def = [0, 0, 0]
  end

end
