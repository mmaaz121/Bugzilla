class User < ApplicationRecord

  enum role: {
    super_admin: 0,
    project_manager: 1,
    qa: 2,
    developer: 3
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
