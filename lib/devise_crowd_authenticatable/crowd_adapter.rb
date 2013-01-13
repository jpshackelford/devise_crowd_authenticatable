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
        @new_password = params[:new_password]
      end

      def authenticate!
        @crowd.login(@login, @password)
      end

      def authenticated?
        authenticate!
      end
      
      def authorized?
        DeviseCrowdAuthenticatable::Logger.send("Authorizing user #{@login}")
        authenticated? #&& in_required_groups? && has_required_attribute?
      end
      
      #def change_password!
      #  update_ldap(:userpassword => Net::LDAP::Password.generate(:sha, @new_password))
      #end
      #
      #def in_required_groups?
      #  return true unless ::Devise.ldap_check_group_membership
      #
      #  ## FIXME set errors here, the ldap.yml isn't set properly.
      #  return false if @required_groups.nil?
      #
      #  admin_ldap = LdapConnect.admin
      #
      #  for group in @required_groups
      #    if group.is_a?(Array)
      #      group_attribute, group_name = group
      #    else
      #      group_attribute = "uniqueMember"
      #      group_name = group
      #    end
      #    admin_ldap.search(:base => group_name, :scope => Net::LDAP::SearchScope_BaseObject) do |entry|
      #      unless entry[group_attribute].include? dn
      #        DeviseLdapAuthenticatable::Logger.send("User #{dn} is not in group: #{group_name }")
      #        return false
      #      end
      #    end
      #  end
      #
      #  return true
      #end
      #
      #def has_required_attribute?
      #  return true unless ::Devise.ldap_check_attributes
      #
      #  admin_ldap = LdapConnect.admin
      #
      #  user = find_ldap_user(admin_ldap)
      #
      #  @required_attributes.each do |key,val|
      #    unless user[key].include? val
      #      DeviseLdapAuthenticatable::Logger.send("User #{dn} did not match attribute #{key}:#{val}")
      #      return false
      #    end
      #  end
      #
      #  return true
      #end
      #
      #def user_groups
      #  admin_ldap = LdapConnect.admin
      #
      #  DeviseLdapAuthenticatable::Logger.send("Getting groups for #{dn}")
      #  filter = Net::LDAP::Filter.eq("uniqueMember", dn)
      #  admin_ldap.search(:filter => filter, :base => @group_base).collect(&:dn)
      #end
      #
      #private
      #
      #def self.admin
      #  ldap = LdapConnect.new(:admin => true).ldap
      #
      #  unless ldap.bind
      #    DeviseLdapAuthenticatable::Logger.send("Cannot bind to admin LDAP user")
      #    raise DeviseLdapAuthenticatable::LdapException, "Cannot connect to admin LDAP user"
      #  end
      #
      #  return ldap
      #end
      #
      #def find_ldap_user(ldap)
      #  DeviseLdapAuthenticatable::Logger.send("Finding user: #{dn}")
      #  ldap.search(:base => dn, :scope => Net::LDAP::SearchScope_BaseObject).try(:first)
      #end
      #
      #def update_ldap(ops)
      #  operations = []
      #  if ops.is_a? Hash
      #    ops.each do |key,value|
      #      operations << [:replace,key,value]
      #    end
      #  elsif ops.is_a? Array
      #    operations = ops
      #  end
      #
      #  admin_ldap = LdapConnect.admin
      #
      #  DeviseLdapAuthenticatable::Logger.send("Modifying user #{dn}")
      #  admin_ldap.modify(:dn => dn, :operations => operations)
      #end

    end

  end

end
