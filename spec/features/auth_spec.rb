require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit "/users/new"
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit "/users/new"
      fill_in "Username", with: 'bilal'
      fill_in "Password", with: '249pln'
      click_button "Sign Up"

      expect(page).to have_content 'bilal'
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    visit "/session/new"
    fill_in "Username", with: 'bilal'
    fill_in "Password", with: '249pln'
    click_button "Sign In"

    visit "/users"

    expect(page).to have_content 'bilal'
  end

end

feature "logging out" do

  it "begins with logged out state" do
    expect(page).not_to have_content 'Sign Out'
  end

  it "doesn't show username on the homepage after logout" do
    click_button "Sign Out"
    visit users_url
    expect(page).not_to have_content 'bilal'
  end

end
