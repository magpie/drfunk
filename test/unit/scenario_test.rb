require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase

  def setup
    @scenario = Factory(:scenario)
  end
  
  test "required fields" do
    @scenario.name = nil
    @scenario.plan_id = nil
    @scenario.feature_id = nil
    assert !@scenario.valid?
    assert @scenario.errors.invalid?(:name)
    assert @scenario.errors.invalid?(:plan_id)
    assert @scenario.errors.invalid?(:feature_id)
  end

  test "update timestamp on setup edit" do
    @scenario.updated_at = nil
    @scenario.setup = "set up the test"
    assert_not_nil @scenario.updated_at
  end

  test "duplicate correctly" do
    clone = Scenario.find(@scenario.id).duplicate
    assert_equal clone.name, @scenario.name + " (copy)"
    assert_equal clone.setup, @scenario.setup
    assert_equal clone.requirement, @scenario.requirement
    @scenario.steps.each_with_index do |step, index|
      assert_equal clone.steps[index].description, step.description
      assert_equal clone.steps[index].expected, step.expected
    end
  end
    
end
