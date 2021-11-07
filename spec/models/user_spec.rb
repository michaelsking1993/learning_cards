require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @current_user = create(:user)
  end

  context 'when a user is created' do
    it 'has all the expected attributes' do
      expect(@current_user).to respond_to(:name)
      expect(@current_user).to respond_to(:email)
      expect(@current_user).to respond_to(:encrypted_password)
      expect(@current_user).to respond_to(:reset_password_token)
      expect(@current_user).to respond_to(:reset_password_sent_at)
      expect(@current_user).to respond_to(:remember_created_at)
    end

    it 'does not allow the creation of a 2nd user with the same email' do
      other_user = build(:user, email: @current_user.email)
      expect(other_user).not_to be_valid
    end

    it 'requires an email' do
      other_user = build(:user, email: nil)
      expect(other_user).not_to be_valid
    end

    it 'requires a name' do
      other_user = build(:user, name: nil)
      expect(other_user).not_to be_valid
    end

    it 'requires a password' do
      other_user = build(:user, password: nil)
      expect(other_user).not_to be_valid
    end
  end
end