class ComplexRollController
  DICE_SIDE_OPTIONS = [4, 6, 8, 10, 20, 100]

  attr_accessor :results_label, :roll_button
  attr_accessor :d4_dice_field, :d6_dice_field, :d8_dice_field, :d10_dice_field, :d20_dice_field, :d100_dice_field
  attr_accessor :roller

  def roll(sender)
    _dice = capture_dice
    unless _dice.empty?
      @roller = Roller.new(_dice)
      results_label.stringValue = @roller.roll
    end
  end

  def capture_dice
    DICE_SIDE_OPTIONS.inject({}) do |hash, sides|
      _dice = self.send(:"d#{sides}_dice_field").floatValue.to_i
      p _dice
      hash[sides] = _dice unless _dice.zero?
      hash
    end
  end
end
