class Plan < ActiveRecord::Base
  has_many :scenarios, :dependent => :destroy
  has_many :features, :dependent => :destroy
  
  validates_presence_of :name
  named_scope :name_sorted, :order => "name"
end
