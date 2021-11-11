class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :learning_items

  after_create_commit :seed_sample_learning_items, unless: :_skip_seeding

  attr_accessor :_skip_seeding # used in factory to prevent extra items from being created

  def seed_sample_learning_items
    learning_items.create(title: 'Something I have not learned (SAMPLE)',
                          confusing_part: 'I do not understand why this exists.',
                          is_learned: false,
                          documentation: nil)
    learning_items.create(title: 'Something I already learned (SAMPLE)',
                          confusing_part: 'I did not understand where to find it',
                          documentation: 'This is a description of the answer. Find more details at [this link]',
                          is_learned: true)
  end
end