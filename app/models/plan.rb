class Plan < ActiveRecord::Base
  has_many :use_cases
  
  validates_presence_of :name
end
