class User < ApplicationRecord
  enum role: {
    # super_admin: 0,
    project_manager: 1,
    qa: 2,
    developer: 3
  }

  has_one_attached :image

  has_many :assigns, dependent: :destroy
  has_many :projects, through: :assigns

  has_many :bugs, dependent: :nullify
  has_many :features, dependent: :nullify

  validates :role, presence: :true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
