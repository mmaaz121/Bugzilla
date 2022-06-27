class Feature < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum status: {
    new_feature: 0,
    in_progress: 1,
    in_review: 2,
    complete: 3
  }

  validates :title, presence: true
  validates :comment, presence: true, length: { minimum: 10 }

  validate :assigned_user_should_be_valid, if: :user

  private
  def assigned_user_should_be_valid
    return if user.developer? && project.users.include?(user)
    errors.add(:user_id, "User assigned on a project must be valid")
  end
end
