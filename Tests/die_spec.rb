require 'spec'

describe "Die" do
  describe "a new Die" do
    before { @die = Die.new }
    it "should have 6 sides" do
      @die.sides.should == 6
    end
    it "should roll between 1 and 6" do
      100.times { @die.roll.should be_between(1,6) }
    end
  end
  describe "a D3" do
    before { @die = Die.new(3) }
    it "should have 3 sides" do
      @die.sides.should == 3
    end
    it "should roll between 1 and 3" do
      100.times { @die.roll.should be_between(1, 3) }
    end
  end
end
