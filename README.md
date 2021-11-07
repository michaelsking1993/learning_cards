# Learning Cards

Welcome to learning cards.

To run this app:
 1. `git clone https://github.com/michaelsking1993/learning_cards.git`
 2. `rails db:migrate`
 3. `rails s localhost:3000`
 
This app has the following features:
 1. Sign up / sign in
 2. Go to your dashboard to see your learning cards (things you've learned or want to learn)
 3. Create a learning item. Fill in the title (required), the confusing part (the part that confused/confuses you
 about this thing), mark it as learned/not learned, and optionally document the details (the "answer", i.e.
 what you actually learned. If you haven't yet learned this thing, leave it blank)
 4. See all your learning items, ordered by most recent to oldest.
 5. Mark/unmark a learning item as learned. Learned items appear in green, unlearned items appear in yellow.
 6. Edit an item, destroy an item.

# Tests
Given that this is a full-stack application, I opted to use integration tests with Capybara for
the majority of the functionality.

This allowed me to ensure that the entire feature flow was working.

I started by writing the tests, and then filled in the functionality.

Normally, when adding small tweaks to an already-existing system, I would write much more specific tests,
particularly for API-only rails applications; but, as stated above, since this is a full-stack sample application,
my instincts told me that feature testing was the most understandable and most effective way to test this app.

# Linting
I used rubocop to fix style things. I ignored some rules, followed others.