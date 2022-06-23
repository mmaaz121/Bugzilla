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

  validate :assigned_user_should_be_valid


  private
  def assigned_user_should_be_valid
    @project = Project.find(self.project_id)
    @project.users.each do |user|
      if user.id == self.user_id and user.role == "developer"
        return true
      end
    end
    errors.add(:user_id, "User assigned on a project must be valid")
  end
end
