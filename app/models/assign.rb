class Assign < ApplicationRecord

  # validate :record_should_be_unique
  validates :user_id, uniqueness: { scope: :project_id, message: "Record must be unique" }

  belongs_to :user
  belongs_to :project

  private
  def record_should_be_unique
    @projects = Assign.where(project_id: self.project_id)
    @projects.each do |project|
      if project.user_id == self.user_id
        errors.add(:id, "Record must be unique")
      end
    end
  end
end
