class Scenario < ActiveRecord::Base
  belongs_to :plan
  belongs_to :feature
  has_many :steps, :dependent => :destroy, :order => "position"
  before_create :set_position

  validates_presence_of :name, :plan_id, :feature_id
  self.record_timestamps = false

  named_scope :other_scenarios, lambda {|scenario|
    {:conditions => ["id != ?", scenario.id]}
  }
  named_scope :with_setup, :conditions => ["setup != ''"]
  named_scope :updated_first, :order => "updated_at DESC"

  private

  def set_position
    self.position = feature.scenarios.length + 1
    self.updated_at = Time.now
  end
end
