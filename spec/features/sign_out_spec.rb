require 'rails_helper'

RSpec.describe 'Signing out', type: :feature do
  before do
    @user = create(:user)
    sign_in @user
  end

  context 'when clicking logout' do
    it 'takes you to the non-logged in version of the landing page' do
      visit root_path
      click_on 'Sign out'
      expect(page).to have_button('Login')
    end
  end
end