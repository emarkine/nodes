# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nodes_session',
  :secret      => '1e1eb2180850d4e68b3bbf6c1df25578bda3d04c628e7a26ffdb0195d4fd8909932af40016edd6747bd45a94ebe17c2d12aa669f18e7205f365ab69f8bcc9e47'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
