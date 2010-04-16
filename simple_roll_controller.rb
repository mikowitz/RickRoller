class SimpleRollController
  attr_accessor :sides_selector, :dice_count_field, :roll_button
  attr_accessor :sides, :dice, :roller
  attr_accessor :rr_controller

  def roll(sender)
    @sides = capture_sides
    @dice = capture_dice
    @roller = Roller.new(sides => dice)
    @rr_controller.add_roll(@roller)
  end

  def capture_sides
    selected_segment = sides_selector.selectedSegment
    label = sides_selector.labelForSegment(selected_segment)
    label.to_i
  end

  def capture_dice
    text_value = dice_count_field.floatValue
    text_value.to_i
  end
end

