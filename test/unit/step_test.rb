require 'test_helper'

class StepTest < ActiveSupport::TestCase
 
  def setup
    @scenario = Factory(:scenario)
    @step = Factory(:step, :scenario => @scenario)
    @scenario.reload
    @step2 = Factory(:step, :scenario => @scenario)
  end

  test "required fields" do
    @step.scenario_id = nil
    assert !@step.valid?
    assert @step.errors.invalid?(:scenario_id)
  end

  test "timestamp parent scenario when created" do
    assert_equal @step.created_at.to_s, @scenario.updated_at.to_s
  end

  test "set position correctly for first and second" do
    assert_equal 1, @step.position
    assert_equal 2, @step2.position
  end

  test "update positions on delete" do
    @scenario.reload
    @step.destroy
    @step2.reload
    assert_equal 1, @step2.position
  end
end
