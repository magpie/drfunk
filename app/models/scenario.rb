class Scenario < ActiveRecord::Base
  belongs_to :plan
  belongs_to :feature
  has_many :steps, :dependent => :destroy, :order => "position"

  before_validation_on_create :set_feature
  validates_presence_of :name, :plan_id, :feature_id
  
  private

  def set_feature 
    if self.plan.features.size == 0
      @f = Feature.create( {:name => "New Feature", :plan_id => self.plan_id})
    else
      @f = self.plan.features.last_updated.first
    end

    self.feature_id = @f.id
  end
end
