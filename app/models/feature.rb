class Feature < ActiveRecord::Base
  belongs_to :plan
  has_many :scenarios, :order => "position"
  
  validates_presence_of :plan_id, :name

  named_scope :name_sorted, :order => "name"
  named_scope :last_updated, :order => "updated_at DESC"
end
