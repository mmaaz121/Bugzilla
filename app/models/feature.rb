class Feature < ApplicationRecord
  enum status: {
    new_feature: 0,
    in_progress: 1,
    in_review: 2,
    complete: 3
    # fixed: 4
  }

  belongs_to :project
  belongs_to :user

  validates :title, presence: true
  validates :comment, presence: true, length: { minimum: 10 }
end
