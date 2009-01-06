require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  should_belong_to :plan
  should_have_many :scenarios
  
  should_require_attributes :plan_id, :name
  should_have_named_scope :name_sorted, :order => "name"

  context "A feature with a scenario" do
    setup do
      @feature = Factory(:feature)
      @scenario = Factory(:scenario, :feature => @feature)
      @feature.reload
    end

    should "not be deleted" do
      @feature.destroy
      assert_not_nil Feature.find(@feature.id)
    end
  end

  context "A feature without a scenario" do
    setup do
      @feature = Factory(:feature)
    end

    should "be deleted" do
      @feature.destroy
      assert_raise ActiveRecord::RecordNotFound do
        Feature.find(@feature.id)
      end
    end
  end
end
