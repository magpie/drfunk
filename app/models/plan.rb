class Plan < ActiveRecord::Base
  has_many :use_cases, :order => "position"
  
  validates_presence_of :name

  def start_test_run
    for use_case in use_cases
      use_case.run_result = UseCase::NO_RESULT 
      use_case.save
    end
  end
end
