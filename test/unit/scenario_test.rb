require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase
  should_belong_to :plan
  should_belong_to :feature
  should_have_many :steps
  
  should_require_attributes :name, :plan_id, :feature_id
  should_have_named_scope "other_scenarios(Scenario.new)", :conditions=>["id != ?", nil]
  should_have_named_scope :with_setup, :conditions => ["setup != ''"]
  should_have_named_scope :updated_first, :order => "updated_at DESC"
  should_have_named_scope "filter('AbC')", :conditions => ["lower(name) like ? or lower(requirement) like ?", "%abc%", "%abc%"]
  should_have_named_scope "filter(nil)", {}

  context "A scenario" do
    setup do
      @scenario = Factory(:scenario)
      @step1 = Factory(:step, :scenario => @scenario)
      @scenario.reload
    end

    should "update timestamp on setup edit" do
      @scenario.updated_at = nil
      @scenario.setup = "set up the test"
      assert_not_nil @scenario.updated_at
    end

    should "duplicate correctly" do
      clone = Scenario.duplicate(@scenario.id)
      assert_equal clone.name, @scenario.name + " (copy)"
      assert_equal clone.setup, @scenario.setup
      assert_equal clone.requirement, @scenario.requirement
      @scenario.steps.each_with_index{|step, index|
        assert_equal clone.steps[index].description, step.description
        assert_equal clone.steps[index].expected, step.expected
      }
    end

    should "copy setup" do
      setup_text = "set up the test!"
      @scenario.setup = setup_text
      @scenario.save
      scenario2 = Factory(:scenario)
      scenario2.copy_setup(@scenario.id)
      assert_equal scenario2.setup, @scenario.setup
    end
    
  end
end
