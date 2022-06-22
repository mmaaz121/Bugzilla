class Bug < ApplicationRecord
  enum status: {
    new_bug: 0,
    in_progress: 1,
    in_review: 2,
    # complete: 3,
    fixed: 4
  }

  belongs_to :project
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :comment, presence: true, length: { minimum: 10 }
end
