require 'rails_helper'

RSpec.describe 'visiting the dashboard', type: :feature do

  before do
    @user = create(:user)
  end

  context 'when not logged in' do
    it 'returns me to the non-logged-in version of the landing page' do
      visit dashboard_path
      expect(page).to have_button('Login')
      expect(page).to have_button('Sign up')
    end
  end

  context 'when logged in' do
    before do
      sign_in @user
    end

    context 'when I have no learning items' do
      it 'shows me a message explaining that my learning items will be found here once I have them' do
        visit dashboard_path
        expect(page).to have_content('Your learning items will appear here once you create them')
        expect(page).to have_link('Create a new learning item')
      end
    end

    context 'when I have 3 learning items' do
      it 'shows me my 3 items, ordered from most recent to oldest' do
        create_list(:learning_item, 3, title: 'Something I learned', user: @user)
        visit dashboard_path
        expect(page).to have_content('Something I learned', count: 3)
        items = @user.learning_items.order(created_at: :desc)
        most_recent_item_title = "#3: #{items[0].title}"
        oldest_item_title = "#1: #{items[-1].title}"
        # assert order through a regex... a bit weird but works.
        location_of_most_recent_item = page.html =~ /#{most_recent_item_title}/
        location_of_oldest_item = page.html =~ /#{oldest_item_title}/
        expect(location_of_most_recent_item < location_of_oldest_item)
      end
    end

    context 'when other users have learning items' do
      it 'does not show me their learning items' do
        other_user = create(:user, email: 'some-other-email@gmail.com')
        create(:learning_item, user: other_user, title: 'Something another user learned')
        visit dashboard_path
        expect(page).not_to have_content('Something another user learned')
        expect(page).to have_content('Your learning items will appear here once you create them')
      end
    end

    context 'when I want to create a learning item' do
      context 'when I fill in with valid attributes' do
        it 'lets me go create a new learning item' do
          expect(LearningItem.count).to eq(0)
          visit dashboard_path
          click_on 'Create a new learning item'
          assert_current_path('/learning_items/new')
          fill_in 'Title', with: 'Caching in Rails'
          fill_in 'learning_item_confusing_part', with: 'I just do not understand when it is automatic and when it is not'
          fill_in 'Documentation', with: 'I do not understand it yet so I will fill it in later once I do understand.'
          click_on 'Submit'
          expect(LearningItem.count).to eq(1)
          assert_current_path('/dashboard')
          expect(page).to have_content('Caching in Rails').once
          expect(page).to have_content('I just do not understand when it is automatic and when it is not')
          expect(page).to have_content('I do not understand it yet so I will fill it in later once I do understand.')
          expect(page).to have_content('Dashboard')
        end
      end

      context 'when I do not fill in the form with valid attributes' do
        it 'does NOT let me create a learning item' do
          visit dashboard_path
          click_on 'Create a new learning item'
          assert_current_path('/learning_items/new')
          # don't fill_in any fields, which should not let me create it.
          click_on 'Submit'
          expect(LearningItem.count).to eq(0)
          # we should still be on the new item form, since it did not submit successfully.
          expect(page).to have_content('2 errors prohibited this learning_item from being saved')
        end
      end
    end

    context 'when I want to destroy an item' do
      it 'lets me destroy the item and refreshes the page' do
        create(:learning_item, user: @user)
        visit dashboard_path
        expect(page).to have_content('Caching in Rails')
        click_on 'Destroy'
        expect(LearningItem.count).to eq(0)
        expect(page).not_to have_content('Caching in Rails')
        assert_current_path('/dashboard')
      end
    end

    context 'when I want to edit an item' do
      it 'lets me go to an edit form, edit the item, and save the edits successfully' do
        create(:learning_item, user: @user)
        visit dashboard_path
        expect(page).to have_link('Edit').once
        click_on 'Edit'
        fill_in('Title', with: 'new title')
        fill_in('learning_item_confusing_part', with: 'something new that confused me')
        fill_in('Documentation', with: 'this explains the actual behavior or what it is that I learned.')
        click_on 'Submit'
        assert_current_path('/dashboard')
        item = LearningItem.first
        expect(item.title).to eq('new title')
        expect(item.confusing_part).to eq('something new that confused me')
        expect(item.documentation).to eq('this explains the actual behavior or what it is that I learned.')
        # should redirect ot the dashbaord page.
        assert_current_path('/dashboard')
        expect(page).to have_content(item.title)
        expect(page).to have_content(item.confusing_part)
        expect(page).to have_content(item.documentation)
      end
    end

    context 'when I want to mark an item as learned' do
      it 'lets me mark it as learned and updates the page accordingly' do
        create(:learning_item, user: @user)
        visit dashboard_path
        click_on 'Mark as learned'
        assert_current_path('/dashboard')
        expect(LearningItem.first.is_learned).to be_truthy
        expect(page).to have_link('Mark as not learned')
      end
    end

    context 'when I want to unmark an item as learned' do
      it 'lets me unmark it and updates the page accordingly' do
        create(:learning_item, user: @user, is_learned: true)
        visit dashboard_path
        click_on 'Mark as not learned'
        assert_current_path('/dashboard')
        expect(LearningItem.first.is_learned).to be_falsey
        expect(page).to have_link('Mark as learned')
      end
    end
  end
end