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
end
