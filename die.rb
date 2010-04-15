class Die
  attr_accessor :sides

  def initialize(sides=6)
    @sides = sides
  end

  def roll
    rand(sides) + 1
  end
end
