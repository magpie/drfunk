source 'http://rubygems.org'
#gem "rails", "3.0.0.beta4"
gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'RedCloth', :require => "redcloth"
gem 'prawn'

group :development do
  gem 'mysql'
end

group :production do
  # postgres for heroku deployment
  gem 'pg'
  # gem 'mysql'
end

group :test do
  gem "factory_girl_rails"
end
