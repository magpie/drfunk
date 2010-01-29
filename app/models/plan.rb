class Plan < ActiveRecord::Base
  include Plan::XmlRestore

  has_many :scenarios, :dependent => :destroy
  has_many :features, :order => "name", :dependent => :destroy

  validates_presence_of :name
  named_scope :name_sorted, :order => "name"

  def step_count
    Step.count(:conditions => ["scenario_id in (?)", scenarios])
  end

  def percent_tested
    total_steps = step_count
    return 100 if total_steps == 0

    ((tested_step_count.to_f / total_steps.to_f) * 100).to_i
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

    matches.sort {|a,b| a.feature.name <=> b.feature.name}
  end

  def self.create_from_xml(xml_file)
    begin
      xml = xml_file.read
      Plan.transaction do
        Plan::XmlRestore.create(xml)
      end
    rescue => e
      logger.error("Problem reading from xml backup: " + e.to_s)
    end
  end

  private

  def tested_step_count
    Step.count(:conditions => ["scenario_id in (?)", scenarios.tested])
  end

end

