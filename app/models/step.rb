class Step < ActiveRecord::Base
  belongs_to :scenario
  before_create :set_position
  before_destroy :update_step_positions

  private

  def set_position
    self.position = scenario.steps.length + 1
  end

  def update_step_positions
    scenario.steps.each do |step|
      if step.position > position
        step.position = step.position - 1
        step.save
      end
    end
  end
end
