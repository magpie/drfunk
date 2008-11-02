class UseCase < ActiveRecord::Base
  belongs_to :plan
  has_many :steps, :order => "position"

  validates_presence_of :name, :plan_id

  def update_positions_for_delete(delete_position)
  begin
    for step in steps
      if step.position > delete_position
        step.position = step.position - 1
        step.save
      end
    end
  rescue => e
    puts e
  end
  end
end
