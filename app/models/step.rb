class Step < ActiveRecord::Base
  belongs_to :scenario
  before_destroy :update_step_positions

  def update_step_positions
    scenario.steps.each do |step|
      if step.position > position
        step.position = step.position - 1
        step.save
      end
    end
  end
end
