# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_osarchive_session',
  :secret      => '10d374d70cfe45ff906c50ec4e14937d4c72968d1abd87bc3380b145d101830f4025f43763bed5e7b1dfa6d16c70b87cd181794b2c1049089719690eaf56934e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
