require_relative '../../spec/rspec_config'
require_relative '../../models/user'
require 'digest/sha1'

puts "In user_spec"

describe "User" do

  describe "validate_input_login" do
    it "works with an empty username" do
      User.validate_input_login("", "pass").should eq false
    end

    it "works with an empty pass" do
      User.validate_input_login("a", "").should eq false
    end

    it "works with two empty fields" do
      User.validate_input_login("", "").should eq false
    end

    it "works with correct fields" do
      User.validate_input_login("a", "b").should eq true
    end
  end

  describe "add_user" do
    it "adds a user successfully" do
      expect do
        User.add_user(:username => "username", :password => "password", :name => "Name")
      end.to change(User, :count).by(1)
    end

    it "fails to add user when the password is emtpy" do
      expect do
        User.add_user(:username => "username", :password => "", :name => "Name")
      end.to change(User, :count).by(0)
    end

    it "fails to add user when the name is emtpy" do
      expect do
        User.add_user(:username => "username", :password => "password", :name => "")
      end.to change(User, :count).by(0)
    end

    it "fails to add user when the username is emtpy" do
      expect do
        User.add_user(:username => "", :password => "password", :name => "Name")
      end.to change(User, :count).by(0)
    end
  end

  describe 'login' do
    it 'logs in an existing user' do
      user = FactoryGirl.create(:user)
      User.login('username', 'password')

      User.find(user.id).login.should eq true
    end

    it 'does not login a non-existing user' do
      user = FactoryGirl.create(:user)
      User.login('fake_user', 'fake_password')

      User.find(user.id).login.should eq false
    end
  end

  describe 'get_current_user' do
    it 'returns the correct user' do
      FactoryGirl.create(:user)
      User.login('username', 'password')
      User.get_current_user.should == {
        "id"=>1,
        "username"=>"username",
        "password"=>Digest::SHA1.hexdigest("password"),
        "name"=>"Some User",
        "admin"=>false,
        "login"=>true}
    end
  end

  describe 'get_current_user_name' do
    it 'returns the correct name' do
      user = FactoryGirl.create(:user)
      User.login('username', 'password')
      User.get_current_user_name.should eq "Some User"
    end
  end

  describe 'is_there_current_user' do
    it 'returns true if there is a current user' do
      user = FactoryGirl.create(:user)
      User.login('username', 'password')
      User.is_there_current_user.should eq true
    end

    it 'returns false if there is not a current user' do
      user = FactoryGirl.create(:user)
      User.is_there_current_user.should eq false
    end
  end

end