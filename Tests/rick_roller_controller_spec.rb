describe "RickRollerController" do
  before do
    @rr_controller = RickRollerController.new
    @rr_controller.rolls = []
  end
  it "should have an empty @rolls array" do
    @rr_controller.rolls.should be_empty
  end
  describe "adding a simple roll" do
    before do
      @simple = SimpleRollController.new
      @simple.rr_controller = @rr_controller
      label = mock(:results_label)
      label.stub!(:stringValue=).and_return("")
      @simple.stub!(:results_label).and_return(label)
      @simple.stub!(:capture_sides).and_return(6)
      @simple.stub!(:capture_dice).and_return(1)
      @simple.roll(nil)
    end
    it "should have a single roll" do
      @rr_controller.rolls.size.should == 1
    end
    it "should have the correct single roll" do
      @rr_controller.rolls.should == ["D6"]
    end
    describe "rolling again" do
      before do
        @simple.roll(nil)
      end
      it "should not add another roll to @rolls" do
        @rr_controller.rolls.size.should == 1
      end
      describe "rolling a different roll" do
        before do
          @simple.stub!(:capture_sides).and_return(8)
          @simple.roll(nil)
        end
        it "should add a single roll to @rolls" do
          @rr_controller.rolls.size.should == 2
        end
        it "should have the correct rolls" do
          @rr_controller.rolls.should == ["D6", "D8"]
        end
        describe "rolling a complex roll" do
          before do
            @complex = ComplexRollController.new
            @complex.rr_controller = @rr_controller
            field = mock(:dice_field)
            field.stub!(:floatValue).and_return(0)
            ComplexRollController::DICE_SIDE_OPTIONS.each do |n|
              @complex.stub!(:"d#{n}_dice_field").and_return(field)
            end
            label = mock(:results_label)
            label.stub!(:stringValue=).and_return("")
            @complex.stub!(:results_label).and_return(label)
            @complex.stub!(:capture_dice).and_return({6 => 2, 4 => 2, 20 => 1, 100 => 3})
            @complex.roll(nil)
          end
          it "should add another roll" do
            @rr_controller.rolls.size.should == 3
          end
          it "should add the correct roll" do
            @rr_controller.rolls.should == ["D6", "D8", "2D4, 2D6, D20, 3D100"]
          end
        end
      end
    end
  end
end
