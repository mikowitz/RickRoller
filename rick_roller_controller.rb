require 'fileutils'

class RickRollerController
  attr_accessor :simple_roll_controller, :complex_roll_controller
  attr_accessor :rolls
  
  PATH_NAME = "~/Library/Application\ Support/RickRoller/"
  ROLLS_PATH = PATH_NAME + "rolls"

  def applicationDidFinishLaunching(sender)
    p "HELLO!"
    @simple_roll_controller.rr_controller = self
    @complex_roll_controller.rr_controller = self
    if File.exists?(ROLLS_PATH)
      roll_data = File.open(ROLLS_PATH) {|f| f.readlines }.join("")
      @rolls = Marshal.load(roll_data)
    else
      @rolls = []
    end
    p @rolls
  end

  def add_roll(roller)
    @rolls << roller.description
    @rolls.uniq!
  end
  
  def applicationWillTerminate(sender)
    rolls = Marshal.dump(@rolls)
    save_to_file(rolls)
  end

  def save_to_file(marshaled_data)
    FileUtils.makedirs(PATH_NAME) unless File.exists?(PATH_NAME)
    File.open(PATH_NAME + "rolls", "w") do |f|
      f << marshaled_data
    end
  end
end
