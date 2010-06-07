require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  
  test "name is required" do
    plan = Plan.new
    assert !plan.valid?
    assert plan.errors[:name].any?
  end

  test "get number of steps for scenarios" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    scenario2 = Factory(:scenario, :plan => plan)
    1.times{ Factory(:step, :scenario => scenario) }
    42.times{ Factory(:step, :scenario => scenario2) }

    plan2 = Factory(:plan)
    scenario3 = Factory(:scenario, :plan => plan2)
    66.times{ Factory(:step, :scenario => scenario3) }

    plan = Plan.find(plan.id)
    assert_equal 43, plan.step_count
    plan2 = Plan.find(plan2.id)
    assert_equal 66, plan2.step_count
  end

end
