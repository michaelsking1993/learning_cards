require 'rails_helper'

RSpec.describe LearningItem, type: :model do
  before do
    @current_user = create(:user)
  end

  context 'when an item is created' do
    it 'has all the expected attributes' do
      learning_item = LearningItem.new
      expect(learning_item).to respond_to(:title)
      expect(learning_item).to respond_to(:confusing_part)
      expect(learning_item).to respond_to(:is_learned)
      expect(learning_item).to respond_to(:documentation)
      expect(learning_item).to respond_to(:user_id)
    end

    it 'does not allow the creation of a learning item without a user' do
      learning_item = build(:learning_item, user_id: nil)
      expect(learning_item).not_to be_valid
    end

    it 'does not allow the creation of a learning item without a title' do
      learning_item = build(:learning_item, title: nil)
      expect(learning_item).not_to be_valid
    end
  end
end