require 'rails_helper'

RSpec.describe 'Visiting the splash page', type: :feature do
  before do
    @user = create(:user)
  end

  context 'when not logged in' do
    it 'has buttons for logging in and signing up, not for dashboard or singing out' do
      visit root_path
      expect(page).to have_button('Sign up')
      expect(page).to have_button('Login')
      expect(page).not_to have_button('Go to dashboard')
      expect(page).not_to have_button('Sign out')
      expect(page).to have_content('Learning Cards')
      expect(page).to have_content('organize your learning')
    end
  end

  context 'When logged in' do
    it 'has buttons for going to dashboard and logging out, not signing up or logging in' do
      sign_in @user
      visit root_path
      expect(page).to have_button('Go to dashboard')
      expect(page).to have_button('Sign out')
      expect(page).not_to have_button('Sign up')
      expect(page).not_to have_button('Login')
      expect(page).to have_content('Learning Cards')
      expect(page).to have_content('organize your learning')
    end
  end
end