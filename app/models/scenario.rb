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
  named_scope :filter, lambda { |value| 
    if value.nil? then return {} end
    {:conditions => ["lower(name) like ? or lower(requirement) like ?", "%#{value.downcase}%", "%#{value.downcase}%"] }
  }

  def setup= new_setup
    self[:setup] = new_setup
    self.updated_at = Time.now
  end

  def self.duplicate(id)
    other_scenario = Scenario.find(id)
    other_scenario.name += " (copy)"
    scenario = Scenario.create(other_scenario.attributes)

    other_scenario.steps.each do |other_step|
      other_step.scenario = scenario
      Step.create(other_step.attributes)
    end
    return scenario
  end

  def copy_setup(other_id)
    other_scenario = Scenario.find(other_id)
    update_attribute(:setup, other_scenario.setup)
  end

  private

  def set_position
    self.position = feature.scenarios.length + 1
    self.updated_at = Time.now
  end
end
