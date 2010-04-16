require 'fileutils'

class RickRollerController
  attr_accessor :simple_roll_controller, :complex_roll_controller
  attr_accessor :recent_rolls_table_view, :results_label
  attr_accessor :rolls
  
  PATH_NAME = "~/Library/Application\ Support/RickRoller/"
  ROLLS_PATH = PATH_NAME + "rolls"

  def applicationDidFinishLaunching(sender)
    @simple_roll_controller.rr_controller = self
    @complex_roll_controller.rr_controller = self
    if File.exists?(ROLLS_PATH)
      roll_data = File.open(ROLLS_PATH) {|f| f.readlines }.join("")
      @rolls = Marshal.load(roll_data)
    else
      @rolls = []
    end
    @recent_rolls_table_view.dataSource = self
    @recent_rolls_table_view.setDoubleAction(:roll_from_table)
  end

  def add_roll(roller)
    @rolls << roller.description
    @rolls.uniq!
    @recent_rolls_table_view.reloadData
    @results_label.stringValue = roller.roll
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

  def roll_from_table
    index = @recent_rolls_table_view.clickedRow
    roll = @rolls[index]
    roller = Roller.from_description(roll)
    add_roll(roller)
  end

  def clear_rolls(sender)
    @rolls = []
    @recent_rolls_table_view.reloadData
  end

  # TableView methods
  def numberOfRowsInTableView(view)
    @rolls.size
  end

  def tableView(view, objectValueForTableColumn:column, row:index)
    roll = @rolls[index]
    case column.identifier
    when "roll" then roll.description
    end
  end
end
