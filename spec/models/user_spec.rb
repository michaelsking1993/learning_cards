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

    it 'creates two sample learning items to show the user how it works' do
      other_user = build(:user, email: 'unique_email@gmail.com')
      other_user._skip_seeding = false
      other_user.save
      learning_items = other_user.learning_items
      expect(learning_items.size).to eq(2)
      learned_item = learning_items.find(&:is_learned)
      unlearned_item = learning_items.find { |item| !item.is_learned }
      expect(unlearned_item.title).to eq('Something I have not learned (SAMPLE)')
      expect(unlearned_item.confusing_part).to eq('I do not understand why this exists.')
      expect(unlearned_item.documentation).to be_nil
      expect(learned_item.title).to eq('Something I already learned (SAMPLE)')
      expect(learned_item.confusing_part).to eq('I did not understand where to find it')
      expect(learned_item.documentation).to eq('This is a description of the answer. Find more details at [this link]')
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