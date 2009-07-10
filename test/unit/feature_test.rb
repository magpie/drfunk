require 'test_helper'

class FeatureTest < ActiveSupport::TestCase

  test "required fields" do
    feature = Factory(:feature)
    feature.name = nil
    feature.plan_id = nil
    assert !feature.valid?
    assert feature.errors.invalid?(:name)
    assert feature.errors.invalid?(:plan_id)
  end

  test "A feature with a scenario" do
    feature = Factory(:feature)
    scenario = Factory(:scenario, :feature => feature)
    feature.reload

    feature.destroy
    assert_not_nil Feature.find(feature.id)
  end

  test "A feature without a scenario" do
    feature = Factory(:feature)

    feature.destroy
    assert_raise ActiveRecord::RecordNotFound do
      Feature.find(feature.id)
    end
  end
end
