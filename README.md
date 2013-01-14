Devise Crowd Authenticatable
===========================

**_Please Note_**
THIS MODULE CAN ONLY DO AUTHENTICATION AT THIS MOMENT.

Devise Crowd Authenticatable is a Crowd based authentication strategy for the
[Devise](http://github.com/plataformatec/devise) authentication framework.

If you are building applications for use within your organization which require
authentication and you want to use Crowd, this plugin is for you.

**_Please Note_**

This Rails plug-in supports ONLY Rails 3.x.

Requirements
------------

- An Crowd server 
- Rails 3.x

These gems are dependencies of the gem:

- Devise > 2.0
- 

Installation
------------

In the Gemfile for your application:

    gem "devise", "~> 2.0"
    gem "devise_crowd_authenticatable"
    
To get the latest version, pull directly from github instead of the gem:

    gem "devise_crowd_authenticatable", :git => "git://github.com/parmarg/devise_crowd_authenticatable.git"


Setup
-----

Run the rails generators for devise (please check the [devise](http://github.com/plataformatec/devise) documents for further instructions)

    rails generate devise:install
    rails generate devise MODEL_NAME

Run the rails generator for devise_crowd_authenticatable

    rails generate devise_crowd_authenticatable:install [options]

This will install the sample.yml, update the devise.rb initializer, and update your user model. There are some options you can pass to it:

Options:

    [--user-model=USER_MODEL]  # Model to update
                               # Default: user
    [--update-model]           # Update model to change from database_authenticatable to crowd_authenticatable
                               # Default: true
    [--add-rescue]             # Update Application Controller with resuce_from for DeviseLdapAuthenticatable::LdapException
                               # Default: true
    [--advanced]               # Add advanced config options to the devise initializer


Usage
-----

Devise Crowd Authenticatable works in replacement of Database Authenticatable

**_Please Note_**

This devise plugin has not been tested with DatabaseAuthenticatable enabled at
the same time. This is meant as a drop in replacement for 
DatabaseAuthenticatable allowing for a semi single sign on approach.

The field that is used for logins is the first key that's configured in the
`config/devise.rb` file under `config.authentication_keys`, which by default is
email. 

Configuration
-------------

In initializer  `config/initializers/devise.rb` :

* crowd\_logger _(default: true)_
  * If set to true, will log Crowd queries to the Rails logger.

* crowd\_create\_user _(default: false)_
	* If set to true, all valid Crowd users will be allowed to login and an appropriate user record will be created.
      If set to false, you will have to create the user record before they will be allowed to login.

* crowd\_config _(default: #{Rails.root}/config/crowd.yml)_
	* Where to find the Crowd config file. Commented out to use the default, change if needed.

* crowd\_update\_password _(default: true)_
  * When doing password resets, if true will update the Crowd server. Requires admin password in the crowd.yml

* crowd\_check\_group_membership _(default: false)_
  * When set to true, the user trying to login will be checked to make sure they are in all of groups specified in the crowd.yml file.

* crowd\_check\_attributes _(default: false)_
  * When set to true, the user trying to login will be checked to make sure they have all of the attributes in the crowd.yml file.

* crowd\_use\_admin\_to\_bind _(default: false)_
  * When set to true, the admin user will be used to bind to the Crowd server during authentication.


Advanced Configuration
----------------------

These parameters will be added to `config/initializers/devise.rb` when you pass the `--advanced` switch to the generator:

* crowd\_auth\_username\_builder _(default: `Proc.new() {|attribute, login, crowd| "#{attribute}=#{login},#{crowd.base}" }`)_
  * You can pass a proc to the username option to explicitly specify the format that you search for a users' DN on your Crowd server.


References
----------

* [Crowd](http://www.atlassian.com/crowd/)
* [Devise](http://github.com/plataformatec/devise)
* [Warden](http://github.com/hassox/warden)


TODO
----
Released under the MIT license

Copyright (c) 2010 Curtis Schiewek, Daniel McNevin, John-Mason P. Shackelford

This is largely ripped-off of Curis Schiewek's Devise LDAP Authenticatable.
