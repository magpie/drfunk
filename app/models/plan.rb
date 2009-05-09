class Plan < ActiveRecord::Base
  include Plan::XmlRestore

  has_many :scenarios, :dependent => :destroy
  has_many :features, :order => "name", :dependent => :destroy

  validates_presence_of :name
  named_scope :name_sorted, :order => "name"

  def step_count
    step_counter = 0
    scenarios.each do |scenario|
      step_counter += scenario.steps.count
    end
    step_counter
  end

  def percent_tested
    total_steps = step_count
    return 100 if total_steps == 0

    tested_steps = 0
    scenarios.tested.each do |tested_scenario|
      tested_steps += tested_scenario.steps.count
    end

    ((tested_steps.to_f / total_steps.to_f) * 100).to_i
  end

  def features_tested
    tested = []
    untested = []
    features.each do |feature|
      if feature.scenarios_tested
        tested << feature
      else
        untested << feature
      end
    end
    return tested, untested
  end

  def clear_results
    scenarios.update_all("result = 'NULL'")
  end

  def search query
    matches = []
    if query.nil? || query.empty?
      return matches
    end

    query = query.downcase

    scenarios.each do |scenario|
      if scenario.search(query)
        matches << scenario
      end
    end

    matches
  end

  def self.create_from_xml(xml_file)
    begin
      xml = xml_file.read
      Plan.transaction do
        Plan::XmlRestore.create(xml)
      end
    rescue => e
      logger.error("Problem reading from xml backup: " + e)
    end
  end

end

