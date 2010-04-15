class Roller
  attr_accessor :dice, :description

  def initialize(dice_opts={6 => 1})
    @dice, @description = parse_opts(dice_opts)
  end

  def roll
  end

  def parse_opts(opts)
    _dice_array, _description = [], []
    opts.keys.sort.each do |_sides|
      _dice = opts[_sides]
      _dice.times { _dice_array << Die.new(_sides) }
      _description << [(_dice == 1 ? "" : _dice), "D", _sides].map(&:to_s).join("")
    end
    [_dice_array, _description.join(", ")]
  end
end
