class UseCase < ActiveRecord::Base
  belongs_to :plan
  has_many :steps, :order => "position"

  validates_presence_of :name, :plan_id
end
