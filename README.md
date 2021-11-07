# Learning Cards

Welcome to learning cards.

To run this app:
 1. `git clonehttps://github.com/michaelsking1993/learning_cards.git`
 2. `rails db:migrate`
 3. `rails s localhost:3000`
 
This app has the following features:
 1. Sign up / sign in
 2. Go to your dashboard to see your learning cards (things you've learend or want to learn)
 3. Create a learning item. Fill in the title (required), the confusing part (the part that confused/confuses you
 about this thing), mark it as learned/not learned, and optionally document the details (the "answer", i.e.
 what you actually learned. If you haven't yet learned this thing, leave it blank)
 4. See all your learning items, ordered by most recent to oldest.
 5. Mark/unmark a learning item as learned. Learned items appear in green, unlearned items appear in yellow.
 6. Edit an item, destroy an item.

# things learned:
 - customizing only specific devise views
https://dev.to/casseylottman/adding-a-field-to-your-sign-up-form-with-devise-10i1
 - capybara view helpers
 
 
 
 rspec ./spec/features/dashboard_spec.rb:130 # visiting the dashboard when logged in when I want to unmark an item as learned lets me unmark it and updates the page accordingly
