class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :assigns, dependent: :destroy
  has_many :projects, through: :assigns

  has_many :bugs, dependent: :nullify
  has_many :features, dependent: :nullify

    enum role: {
    project_manager: 1,
    qa: 2,
    developer: 3
  }

  validates :role, presence: :true

end
