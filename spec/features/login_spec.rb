require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

  before do
    @user = create(:user)
  end

  context 'when logging in with valid inputs' do
    it 'logs in successfully' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
      expect(page).to have_button('Go to dashboard')
    end
  end

  context 'when logging in with invalid inputs' do
    it 'does not login successfully' do
      visit new_user_session_path
      fill_in 'Email', with: 'i-do-not-exist@gmail.com'
      fill_in 'Password', with: 'non-existing-password'
      click_on 'Log in'
      expect(page).to have_button('Log in')
    end
  end
end
