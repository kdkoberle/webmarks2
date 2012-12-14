require 'spec_helper'

describe "User Pages" do
  
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  
  #####################################################
  # Signup pages
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Fullname",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Username",     with: "examplar_user"
        fill_in "Password",     with: "12345678"
        fill_in "Confirmation", with: "12345678"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  
  # Edit pages
  #####################################################################
  describe "edit" do
    let(:submit) { "Edit Profile" }
    
    before { sign_in user }
    before { visit edit_user_path(user) }
    
    describe "with invalid information" do
      before { click_button :submit }

      it { should have_content('The form contains') }
    end

    describe "with valid information" do
      
      let(:new_fullname) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Fullname",         with: new_fullname
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Edit Profile"
      end
      
      specify { user.reload.fullname.should  == new_fullname }
      specify { user.reload.email.should == new_email }
    end
  end

  #######################################################
  # Home page  
  describe "home" do
    before { visit root_path }
    
    describe "Not Logged In" do
      it {should have_button "Log In" }
    end
    
    describe "Loggd in" do
      before { sign_in user }
      before { visit root_path }
      it { should have_content("Welcome to webmarks") }
    end
  end

  ########################################################
  # Show page
  describe "show" do
    before { visit user_path(user) }
    
    describe "wrong user" do
      it { should_not have_content("Edit") }
    end
    
    describe "correct user" do
      before { sign_in(user) }
      it { should have_content("Edit") }
    end
  end



  describe "update" do
    
    describe "submitting to the update action not logged in" do
      before { put user_path(user) }
      specify { response.should redirect_to(login_path) }
    end
    
    describe "trying to update the wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, username: "Jimson") }
      before { sign_in(user) }
      before { put user_path(wrong_user) }
      specify { response.should redirect_to(root_path) }
    end
  end

end
