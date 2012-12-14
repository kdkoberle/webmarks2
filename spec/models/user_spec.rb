# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fullname        :string(255)
#  email           :string(255)
#  username        :string(255)
#  password        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#


require 'spec_helper'

describe User do

  before do
    @user = User.new(fullname: "Keith Koberle", email: "kdkoberle@madisoncollege.edu", username: "kdkoberle",
                     password: "12345678", password_confirmation: "12345678")
  end

  subject { @user }

  it { should respond_to(:fullname) }
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }

  it { should be_valid }
  
  #email invalid email test
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end
  
  #valid email test
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
  
  #check for blank name
  describe "when name is not present" do
    before { @user.fullname = " " }
    it { should_not be_valid }
  end
  
  #for names more than 75 chars should fail
  describe "when name is too long" do
    before { @user.fullname = "a" * 76 }
    it { should_not be_valid }
  end
  
  #checking for names shorter than 2 chars
  describe "when name is too short" do
    before { @user.fullname = "a" }
    it { should_not be_valid}
  end
  #checking for present password
  describe "when password not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  #checking for length of password
  describe "with a password that's too short" do
   before { @user.password = @user.password_confirmation = "a" * 6 }
   it { should be_invalid }
  end
  
  #checking for password and confirmation matching
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  #checking for nil password confirmation
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  #checking for unique username
  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end
  
  #user authentication
  describe "return value of authenticate method" do
   before { @user.save }
  let(:found_user) { User.find_by_username(@user.username) }

  describe "with valid password" do
    it { should == found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not == user_for_invalid_password }
    specify { user_for_invalid_password.should be_false }
  end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
end


