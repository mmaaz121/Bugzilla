class Project < ApplicationRecord
  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns

  has_many :bugs, dependent: :destroy
  has_many :features, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
