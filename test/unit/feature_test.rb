require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  should_belong_to :plan
  should_have_many :scenarios
  
  should_require_attributes :plan_id, :name
  should_have_named_scope :name_sorted, :order => "name"
end
