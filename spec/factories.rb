# keep all factories in one file for now to keep this project simple.

FactoryBot.define do
  factory :user do
    name { 'Joe Shmoe' }
    email { 'help_me_learn@gmail.com' }
    password { 'beeswax' }

    after(:build) do |user|
      user._skip_seeding = true
    end
  end

  factory :learning_item do
    title { 'Caching in Rails' }
    confusing_part { 'When does Rails cache automatically? When do I have to specify?' }
    is_learned { false }
    documentation { 'Insert later after I learn it' }
    user_id { nil }
  end
end