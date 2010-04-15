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
    end
    describe "with 2 D4" do
      before { @roller = Roller.new(4 => 2) }
      it "should roll 2 D4" do
        @roller.dice.should == [Die.new(4)] * 2
      end
      it "should have the correct description" do
        @roller.description.should == "2D4"
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
    end
  end
end
