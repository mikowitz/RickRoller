class Controller
  attr_accessor :sides_selector, :dice_count_field, :results_label, :roller, :roll_button

  def roll(sender)
    @roller = Roller.new
    p @roller
  end

  
end

