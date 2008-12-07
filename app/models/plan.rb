class Plan < ActiveRecord::Base
  has_many :scenarios
  has_many :features
  
  validates_presence_of :name
  named_scope :name_sorted, :order => "name"
end
