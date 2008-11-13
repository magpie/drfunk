class Category < ActiveRecord::Base
  belongs_to :plan
  has_many :use_cases
  
  validates_presence_of :plan_id, :name
end
