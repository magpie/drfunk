class Step < ActiveRecord::Base
  belongs_to :scenario

  validates_presence_of :scenario_id
end
