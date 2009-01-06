require 'test_helper'

class StepTest < ActiveSupport::TestCase
  should_belong_to :scenario
  should_require_attributes :scenario_id
 
  context "A step instance" do
    setup do
      @scenario = Factory(:scenario)
      @step = Factory(:step, :scenario => @scenario)
      @scenario.reload
      @step2 = Factory(:step, :scenario => @scenario)
    end

    should "timestamp parent scenario when created" do
       assert_equal @step.created_at.to_s, @scenario.updated_at.to_s
    end

    should "set position correctly for first and second" do
       assert_equal 1, @step.position
       assert_equal 2, @step2.position
    end

    should "update positions on delete" do
       @scenario.reload
       @step.destroy
       @step2.reload
       assert_equal 1, @step2.position
    end
  end
end
