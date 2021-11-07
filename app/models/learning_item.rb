class LearningItem < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :confusing_part
end