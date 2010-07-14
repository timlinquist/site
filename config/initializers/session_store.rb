# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_v2a_session',
  :secret      => '88fc9fbc952a95a076afdd77b0838b7fd21855c3e9ecff40437285bdceb06bd8ce27a5c4cf97558a67280ff0a1874a3cac8bfe0b62755dc25553d9101d99e84e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
