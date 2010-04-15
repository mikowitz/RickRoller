describe "Controller" do
  describe "a default controller" do
    before do
      @controller = Controller.new
      @controller.stub!(:capture_sides).and_return(6)
      @controller.stub!(:capture_dice).and_return(1)
    end
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
  describe "a non-default controller" do
    before do
      @controller = Controller.new
      @controller.stub!(:capture_sides).and_return(20)
      @controller.stub!(:capture_dice).and_return(3)
    end
    describe "rolling" do
      before { @controller.roll(nil) }
      it "should create a roller" do
        @controller.roller.should_not be_nil
      end
      it "the roller should have the correct description" do
        @controller.roller.description.should == "3D20"
      end
    end
  end
end
