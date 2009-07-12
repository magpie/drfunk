class Scenario < ActiveRecord::Base
  belongs_to :plan
  belongs_to :feature
  has_many :steps, :dependent => :destroy, :order => "position"
  before_create :set_position

  validates_presence_of :name, :plan_id, :feature_id

  named_scope :other_scenarios, lambda {|scenario|
    {:conditions => ["id != ?", scenario.id]}
  }
  named_scope :with_setup, :conditions => ["setup != ''"]
  named_scope :updated_first, :order => "updated_at DESC"
  named_scope :filter, lambda { |value|
    if value.nil? then return {} end
    {:conditions => ["lower(name) like ? or lower(requirement) like ?", "%#{value.downcase}%", "%#{value.downcase}%"] }
  }
  named_scope :tested, :conditions => ["result != 'NULL'"]

  RESULT_UNTESTED = nil
  RESULT_COMPLETE   = "complete"

  def duplicate
    self.name += " (copy)"
    dupe = clone
    dupe.save

    steps.each do |step|
      step.scenario = dupe
      step.clone.save
    end
    dupe
  end

  def search query
    if (name && name.downcase.include?(query)) ||
       (requirement && requirement.downcase.include?(query)) ||
       (setup && setup.downcase.include?(query))
       return true
    end

    steps.each do |step|
      if step.search query
        return true
      end
    end

    false
  end

  private

  def set_position
    self.position = feature.scenarios.size + 1
  end

end
