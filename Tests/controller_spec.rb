describe "Controller" do
  before { @controller = Controller.new }
  describe "rolling" do
    before { @controller.roll(nil) }
    it "should create a roller" do
      @controller.roller.should_not be_nil
    end
    it "the roller should have the default description" do
      @controller.roller.description.should == "D6"
    end
  end
end
