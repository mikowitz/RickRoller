class RickRollerController
  attr_accessor :simple_roll_controller, :complex_roll_controller
  attr_accessor :rolls
  
  def applicationDidFinishLaunching(sender)
    p "HELLO!"
    @simple_roll_controller.rr_controller = self
    @complex_roll_controller.rr_controller = self
    @rolls = []
  end

  def add_roll(roller)
    @rolls << roller.description
    @rolls.uniq!
  end
  
  def applicationWillTerminate(sender)
    p @rolls
  end
end
