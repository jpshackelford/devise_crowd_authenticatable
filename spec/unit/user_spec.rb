require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe 'Users' do

  def should_be_validated(user, password, message = "Password is invalid")
    assert(user.valid_crowd_authentication?(password), message)
  end

  def should_not_be_validated(user, password, message = "Password is not properly set")
    assert(!user.valid_crowd_authentication?(password), message)
  end
  #
  #describe "With default settings" do
  #  before do
  #    default_devise_settings!
  #  end
  #
  #  describe "look up and ldap user" do
  #    it "should return true for a user that does exist in LDAP" do
  #      assert_equal true, ::Devise::CrowdAdapter.valid_login?('admin@medu.com')
  #    end
  #
  #    it "should return false for a user that doesn't exist in LDAP" do
  #      assert_equal false, ::Devise::CrowdAdapter.valid_login?('barneystinson')
  #    end
  #  end
  #
  #  describe "create a basic user" do
  #    before do
  #      @user = Factory.create(:user)
  #    end
  #
  #    it "should check for password validation" do
  #      assert_equal(@user.email, "example.user@test.com")
  #      should_be_validated @user, "secret"
  #      should_not_be_validated @user, "wrong_secret"
  #      should_not_be_validated @user, "Secret"
  #    end
  #  end
  #
  #  describe "change a LDAP password" do
  #    before do
  #      @user = Factory.create(:user)
  #    end
  #
  #    it "should change password" do
  #      should_be_validated @user, "secret"
  #      @user.reset_password!("changed","changed")
  #      should_be_validated @user, "changed", "password was not changed properly on the LDAP sevrer"
  #    end
  #
  #    it "should not allow to change password if setting is false" do
  #      should_be_validated @user, "secret"
  #      @user.reset_password!("wrong_secret", "wrong_secret")
  #      should_not_be_validated @user, "wrong_secret"
  #      should_be_validated @user, "secret"
  #    end
  #  end
  #
  #  describe "create new local user if user is in LDAP" do
  #
  #    before do
  #      assert(User.all.blank?, "There shouldn't be any users in the database")
  #    end
  #
  #    it "should don't create user in the database" do
  #      @user = User.authenticate_with_crowd(:email => "example.user@test.com", :password => "secret")
  #      assert(User.all.blank?)
  #    end
  #
  #    describe "creating users is enabled" do
  #      before do
  #        ::Devise.ldap_create_user = true
  #      end
  #
  #      it "should create a user in the database" do
  #        @user = User.authenticate_with_crowd(:email => "example.user@test.com", :password => "secret")
  #        assert_equal(User.all.size, 1)
  #        User.all.collect(&:email).should include("example.user@test.com")
  #      end
  #
  #      it "should not create a user in the database if the password is wrong_secret" do
  #        @user = User.authenticate_with_crowd(:email => "example.user", :password => "wrong_secret")
  #        assert(User.all.blank?, "There's users in the database")
  #      end
  #
  #      it "should create a user if the user is not in LDAP" do
  #        @user = User.authenticate_with_crowd(:email => "wrong_secret.user@test.com", :password => "wrong_secret")
  #        assert(User.all.blank?, "There's users in the database")
  #      end
  #
  #      it "should create a user in the database if case insensitivity does not matter" do
  #        ::Devise.case_insensitive_keys = []
  #        @user = Factory.create(:user)
  #
  #        expect do
  #          User.authenticate_with_crowd(:email => "EXAMPLE.user@test.com", :password => "secret")
  #        end.to change { User.count }.by(1)
  #      end
  #
  #      it "should not create a user in the database if case insensitivity matters" do
  #        ::Devise.case_insensitive_keys = [:email]
  #        @user = Factory.create(:user)
  #
  #        expect do
  #          User.authenticate_with_crowd(:email => "EXAMPLE.user@test.com", :password => "secret")
  #        end.to_not change { User.count }
  #      end
  #
  #      it "should create a user with downcased email in the database if case insensitivity matters" do
  #        ::Devise.case_insensitive_keys = [:email]
  #
  #        @user = User.authenticate_with_crowd(:email => "EXAMPLE.user@test.com", :password => "secret")
  #        User.all.collect(&:email).should include("example.user@test.com")
  #      end
  #    end
  #
  #  end

    describe "use groups for authorization" do
      before do
        @admin = Factory.create(:admin)
       # @user = Factory.create(:user)
        ::Devise.authentication_keys = [:email]

      end

      it "should admin should be allowed in" do
        should_be_validated @admin, "password"
      end

      #it "should user should not be allowed in" do
      #  should_not_be_validated @user, "secret"
      #end
    end



end
