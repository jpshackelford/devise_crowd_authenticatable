require "crowd-client"

module Devise

  module CrowdAdapter
    
    def self.valid_credentials?(login, password_plaintext)
      options = {:login => login, 
                 :password => password_plaintext}

      resource = CrowdConnect.new(options)
      resource.authorized?
    end
    
    #def self.update_password(login, new_password)
    #  resource = LdapConnect.new(:login => login, :new_password => new_password)
    #  resource.change_password! if new_password.present?
    #end
    #
    #def self.get_groups(login)
    #  ldap = LdapConnect.new(:login => login)
    #  ldap.user_groups
    #end

    class CrowdConnect

      attr_reader :login

      def initialize(params = {})
        crowd_config = YAML.load(ERB.new(File.read(::Devise.crowd_config || "#{Rails.root}/config/crowd.yml")).result)[Rails.env]

        @crowd = Crowd::Client
        @crowd.config.url = crowd_config['crowd_url']
        @crowd.config.application = crowd_config['application']
        @crowd.config.password = crowd_config['password']

        @crowd.connection

        @login = params[:login]
        @password = params[:password]
        #@new_password = params[:new_password]
      end

      def authenticate!
        @crowd.login(@login, @password)
      end

      def authenticated?
        authenticate!
      end
      
      def authorized?
        DeviseCrowdAuthenticatable::Logger.send("Authorizing user #{@login}")
        authenticated?
      end


    end

  end

end
