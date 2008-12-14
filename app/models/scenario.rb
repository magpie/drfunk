class Scenario < ActiveRecord::Base
  belongs_to :plan
  belongs_to :feature
  has_many :steps, :dependent => :destroy, :order => "position"
  has_one :setup, :dependent => :destroy
  before_create :set_position

  validates_presence_of :name, :plan_id, :feature_id

  private

  def set_position
    self.position = feature.scenarios.length + 1
  end
end
