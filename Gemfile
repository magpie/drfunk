source 'http://rubygems.org'
gem "rails", "3.0.3"

gem 'RedCloth', :require => "redcloth"
gem 'prawn'

group :production do
  # postgres for heroku deployment
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3-ruby'
  gem "factory_girl_rails"
end
