require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase
  should_belong_to :plan
  should_belong_to :feature
  should_have_many :steps
  
  should_require_attributes :name, :plan_id, :feature_id
  #should_have_named_scope :other_scenarios 
  should_have_named_scope :with_setup
  should_have_named_scope :updated_first
end
