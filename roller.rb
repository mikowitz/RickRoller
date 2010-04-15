class Roller
  attr_accessor :dice, :description

  def initialize(dice_opts={6 => 1})
    @dice, @description = parse_opts(dice_opts)
  end

  def roll
    if @dice.map(&:sides).uniq.size == 1
      roll_single_die_type
    else
      roll_mixed_dice
    end
  end

  def roll_single_die_type
    _rolls = @dice.map(&:roll)
    _total = _rolls.inject(0) {|n, total| n + total }
    "#{_rolls.join(", ")}\n\nSum: #{_total}"
  end

  def roll_mixed_dice
    _rolls = {}
    _total = 0
    @dice.each do |die|
      _sides = die.sides
      _result = die.roll
      _total += _result
      if _rolls[_sides]
        _rolls[_sides] << _result
      else
        _rolls[_sides] = [_result]
      end
    end
    _results = []
    _rolls.keys.sort.each do |die_size|
      _results << "D#{die_size}: #{_rolls[die_size].join(", ")}"
    end
    _results << ""
    _results << "Total: #{_total}"
    _results.join("\n")
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
