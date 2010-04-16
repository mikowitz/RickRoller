# Only need to check equality for testing
class Die
  def ==(die)
    self.sides == die.sides
  end
end

describe "Roller" do
  describe "roll" do
    describe "with no arguments" do
      before { @roller = Roller.new }
      it "should roll one D6" do
        @roller.dice.should == [Die.new]
      end
      it "should have the correct description" do
        @roller.description.should == "D6"
      end
      it "rolling should return the correct data" do
        @roller.roll.should =~ /\d\n\nTotal: [123456]/
      end
    end
    describe "with 2 D4" do
      before { @roller = Roller.new(4 => 2) }
      it "should roll 2 D4" do
        @roller.dice.should == [Die.new(4)] * 2
      end
      it "should have the correct description" do
        @roller.description.should == "2D4"
      end
      it "rolling should return the correct data" do
        @roller.roll.should =~ /\d, \d\n\nTotal: \d+/
      end
    end
    describe "with 2 D8 and 3 D10" do
      before { @roller = Roller.new(10 => 3, 8 => 2) }
      it "should roll 2D8 and 3D10" do
        @roller.dice.should == [Die.new(8)] * 2 + [Die.new(10)] * 3
      end
      it "should have the correct description" do
        @roller.description.should == "2D8, 3D10"
      end
      it "rolling should return the correct data" do
        @roller.roll.should =~ /D8: \d, \d\nD10: \d+, \d+, \d+\n\nTotal: \d+/
      end
    end
  end
  describe "parsing rolls from descriptions" do
    describe "a simple roll" do
      before { @roll = Roller.from_description("D6") }
      it "should contain a single D6" do
        @roll.dice.should == [Die.new]
      end
    end
    describe "a slightly more complex roll" do
      before { @roll = Roller.from_description("3D20") }
      it "should contain 3 D20" do
        @roll.dice.should == [Die.new(20)] * 3
      end
    end
    describe "a mixed roll" do
      before { @roll = Roller.from_description("2D4, D6, 4D10, 3D100") }
      it "should contain 2 D4, 1 D6, 4 D10, and 3 D100" do
        @roll.dice.should == [Die.new(4)] * 2 + [Die.new] + [Die.new(10)] * 4 + [Die.new(100)] * 3
      end
    end
  end
end
