require 'spec_helper'
require 'rails_helper'



feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    background do
      visit new_user_url
      fill_in 'Username', with: "newuser1"
      fill_in 'Password', with: "password"
      click_button "Sign Up"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content("newuser1")
    end
  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    login_ok_user
    expect(page).to have_content(@ok_user.username)
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit users_url
    expect(page).to have_content("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    login_ok_user
    logout_user
    expect(page).not_to have_content(@ok_user.username)
    expect(current_path).to eq(new_session_path)
  end

end
