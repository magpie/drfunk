# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dr_funk_session',
  :secret      => 'cf4ba998cd4afe503cab6c8066b2e4bd571387a5084f71e54fdf9d02899c93aa57ea6f424c955b5457111e75d25a2cd774150ee8bfdc0bbc52815607f17c680e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
