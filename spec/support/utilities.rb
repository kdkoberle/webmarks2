require 'spec_helper'

def sign_in(user)
  visit login_path
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Log In"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end