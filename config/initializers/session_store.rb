# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_opensite_session',
  :secret      => 'cc3e76b9fe70e8f7f17705f4e3341d0d3c044aa4ded2c29a32ba89605b575524bc8984e9ef32b3f79dfb3870a7fc7203a223023b9311a7fe9997678aaeefa99e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
