class Feature < ActiveRecord::Base
  belongs_to :plan
  has_many :scenarios, :order => "position"
  
  validates_presence_of :plan_id, :name

  named_scope :name_sorted, :order => "name"
  before_destroy :check_for_scenarios

  def check_for_scenarios
    self.scenarios.empty?
  end

  def scenarios_tested
    scenarios.size > 0 && scenarios.size == scenarios.tested.size
  end
end
