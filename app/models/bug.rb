class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  enum status: {
    new_bug: 0,
    in_progress: 1,
    in_review: 2,
    fixed: 4
  }

  validates :title, presence: true
  validates :comment, presence: true, length: { minimum: 10 }

  validate :validate_user_role, if: :user

  private
  def validate_user_role
    return if user.developer? && project.users.include?(user)
    errors.add(:user_id, "User assigned on a project must be valid")
  end
end
