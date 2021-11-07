require 'rails_helper'

RSpec.describe 'Signing up', type: :feature do
  context 'when signing up with valid attributes' do
    it 'takes you to the logged-in version of the landing page with a newly created user' do
      visit root_path
      expect(User.count).to eq(0)
      click_on 'Sign up'
      fill_in 'Name', with: 'some name'
      fill_in 'Email', with: 'some_email@gmail.com'
      fill_in 'Password', with: 'some password'
      fill_in 'Password confirmation', with: 'some password'
      click_on 'Sign up'
      expect(User.count).to eq(1)
      expect(page).to have_button('Go to dashboard')
    end
  end

  context 'when signing up with invalid attributes' do
    it 'remains on the signup page without having created a new user' do
      visit root_path
      expect(User.count).to eq(0)
      click_on 'Sign up'
      fill_in 'Name', with: '' # invalid! This field must be present to create a user!
      fill_in 'Email', with: 'some_email@gmail.com'
      fill_in 'Password', with: 'some password'
      fill_in 'Password confirmation', with: 'some password'
      click_on 'Sign up'
      expect(User.count).to eq(0) # should still be 0 users even after clicking sign up, because this should be invalid.
      expect(page).to have_field('Password')
    end
  end
end