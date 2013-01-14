require 'devise_crowd_authenticatable/strategy'

module Devise
  module Models
    # CROWD Module, responsible for validating the user credentials via Crowd.
    #
    # Examples:
    #
    #    User.authenticate('email@test.com', 'password123')  # returns authenticated user or nil
    #    User.find(1).valid_password?('password123')         # returns true/false
    #
    module CrowdAuthenticatable
      extend ActiveSupport::Concern

      included do
        attr_reader :current_password, :password
        attr_accessor :password_confirmation
      end

      def login_with
        self[::Devise.authentication_keys.first]
      end
      
      def reset_password!(new_password, new_password_confirmation)
        if new_password == new_password_confirmation && ::Devise.ldap_update_password
          Devise::LdapAdapter.update_password(login_with, new_password)
        end
        clear_reset_password_token if valid?
        save
      end

      def password=(new_password)
        @password = new_password
      end

      # Checks if a resource is valid upon authentication.
      def valid_crowd_authentication?(password)
        if Devise::CrowdAdapter.valid_credentials?(login_with, password)
          return true
        else
          return false
        end
      end


      module ClassMethods
        # Authenticate a user based on configured attribute keys. Returns the
        # authenticated user if it's valid or nil.
        def authenticate_with_crowd(attributes={})
          auth_key = self.authentication_keys.first
          return nil unless attributes[auth_key].present?

          auth_key_value = (self.case_insensitive_keys || []).include?(auth_key) ? attributes[auth_key].downcase : attributes[auth_key]

          # resource = find_for_crowd_authentication(conditions)
          resource = where(auth_key => auth_key_value).first

          if (resource.blank?)
            resource = new
            resource[auth_key] = auth_key_value
            resource.password = attributes[:password]
          end
          if resource.try(:valid_crowd_authentication?,attributes[:password])
            resource.save if resource.new_record?
            return resource
          else
            return nil
          end
        end
        
        def update_with_password(resource)
          puts "UPDATE_WITH_PASSWORD: #{resource.inspect}"
        end
        
      end
    end
  end
end
