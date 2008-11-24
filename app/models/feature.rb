class Feature < ActiveRecord::Base
  belongs_to :plan
  has_many :scenarios, :order => "name"
  
  validates_presence_of :plan_id, :name
end
