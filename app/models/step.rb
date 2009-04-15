class Step < ActiveRecord::Base
  belongs_to :scenario
  before_create :set_position
  before_save :timestamp_scenario
  before_destroy :update_step_positions_destroy, :timestamp_scenario
  validates_presence_of :scenario_id

  def search query
    if (description && description.downcase.include?(query)) ||
       (expected && expected.downcase.include?(query))
       return true
    end
     
    false
  end

  private

  def timestamp_scenario
    scenario.updated_at = Time.now
    scenario.save
  end

  def set_position
    if self.position
      update_step_positions_create
    else
      self.position = scenario.steps.length + 1
    end
  end

  def update_step_positions_create
    scenario.steps.each do |step|
      if step.position >= position
        step.position = step.position + 1
        step.save
      end
    end
  end

  def update_step_positions_destroy
    scenario.steps.each do |step|
      if step.position > position
        step.position = step.position - 1
        step.save
      end
    end
  end
end
