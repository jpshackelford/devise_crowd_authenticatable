# encoding: utf-8
require 'devise'

require 'devise_crowd_authenticatable/exception'
require 'devise_crowd_authenticatable/logger'
require 'devise_crowd_authenticatable/schema'
require 'devise_crowd_authenticatable/crowd_adapter'
require 'devise_crowd_authenticatable/routes'

# Get ldap information from config/ldap.yml now
module Devise
  # Allow logging
  mattr_accessor :crowd_logger
  @@cro_logger = true
  
  # Add valid users to database
  mattr_accessor :d_create_user
  @@crowd_create_user = false
  
  mattr_accessor :crowd_config
  # @@ldap_config = "#{Rails.root}/config/ldap.yml"

end

# Add ldap_authenticatable strategy to defaults.
#
Devise.add_module(:crowd_authenticatable,
                  :route => :session, ## This will add the routes, rather than in the routes.rb
                  :strategy   => true,
                  :controller => :sessions,
                  :model  => 'devise_crowd_authenticatable/model')
