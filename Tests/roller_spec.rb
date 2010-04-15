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
        @roller.roll.should =~ /\d\n\nSum: [123456]/
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
        @roller.roll.should =~ /\d, \d\n\nSum: \d+/
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
        pending "handling mixed dice rolls needs to be handled differently, and is not currently an option provided by the UI"
      end
    end
  end
end
