class Assign < ApplicationRecord

  validates :user_id, uniqueness: { scope: :project_id, message: "Record must be unique" }

  belongs_to :user
  belongs_to :project

end
