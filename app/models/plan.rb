class Plan < ActiveRecord::Base
  has_many :scenarios, :order => "position"
  has_many :features, :order => "name"
  
  validates_presence_of :name
end
