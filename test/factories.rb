require 'factory_girl'

Factory.define :plan do |p|
  p.name 'Plan Name'
  p.created_at { Time.now }
  p.updated_at { Time.now }
end

Factory.define :feature do |f|
  f.name 'Feature Name'
  f.plan { |a| a.association :plan}
  f.created_at { Time.now }
  f.updated_at { Time.now }
end

Factory.define :scenario do |s|
  s.name 'Scenario Name'
  s.setup 'Setup the scenario here.'
  s.requirement '12345'
  s.plan { |a| a.association :plan}
  s.feature { |a| a.association :feature}
end

Factory.define :step do |s|
  s.description "step description"
  s.expected "step expectation"
  s.scenario { |a| a.association :scenario}
  s.created_at { Time.now }
  s.updated_at { Time.now }
end
