require 'test_helper'

class StepTest < ActiveSupport::TestCase
  should_belong_to :scenario
  should_require_attributes :scenario_id
end
