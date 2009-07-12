class Scenario < ActiveRecord::Base
  belongs_to :plan
  belongs_to :feature
  has_many :steps, :dependent => :destroy, :order => "position"
  before_save :timestamp
  before_create :set_position

  validates_presence_of :name, :plan_id, :feature_id
  self.record_timestamps = false

  named_scope :other_scenarios, lambda {|scenario| {:conditions => ["id != ?", scenario.id]} }
  named_scope :with_setup, :conditions => ["setup != ''"]
  named_scope :updated_first, :order => "updated_at DESC"
  named_scope :tested, :conditions => ["result != 'NULL'"]

  RESULT_UNTESTED = nil
  RESULT_COMPLETE   = "complete"

  def timestamp
    # prevent timestamp on scenario drag and drop
    if self.changes.size > 0
      if self.changes.include?("position") == false && self.changes.include?("feature_id") == false
        self.updated_at = Time.now
      end
    end
  end

  def duplicate
    dupe = clone
    dupe.name += " (copy)"
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
    self.updated_at = Time.now
  end

end
