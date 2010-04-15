describe "ComplexRollController" do
  before do
    @controller = ComplexRollController.new
    field = mock(:dice_field)
    field.stub!(:floatValue).and_return(0)
    ComplexRollController::DICE_SIDE_OPTIONS.each do |n|
      @controller.stub!(:"d#{n}_dice_field").and_return(field)
    end
    label = mock(:results_label)
    label.stub!(:stringValue=).and_return("")
    @controller.stub!(:results_label).and_return(label)
    @controller.rr_controller = RickRollerController.new
    @controller.rr_controller.rolls = []
  end
  describe "a default controller" do
    before do
      @controller.stub!(:capture_dice).and_return({})
    end
    describe "rolling" do
      before { @controller.roll(nil) }
      it "should not create a roller" do
        @controller.roller.should be_nil
      end
    end
  end
  describe "a controller with a single die type" do
    before do
      @controller.stub!(:capture_dice).and_return({100 => 2})
    end
    describe "rolling" do
      before { @controller.roll(nil) }
      it "should create a roller" do
        @controller.roller.should_not be_nil
      end
      it "the roller should have the correct description" do
        @controller.roller.description.should == "2D100"
      end
    end
  end
  describe "a controller with mixed dice" do
    before do
      @controller.stub!(:capture_dice).and_return({6 => 2, 4 => 3, 10 => 1})
    end
    describe "rolling" do
      before { @controller.roll(nil) }
      it "should create a roller" do
        @controller.roller.should_not be_nil
      end
      it "the roller should have the correct description" do
        @controller.roller.description.should == "3D4, 2D6, D10"
      end
    end
  end
end
