class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
    end
  end

  def index?
    @user.role == 'project_manager'
  end

  def show?
    @user.role == 'project_manager'
  end

  def new?
    @user.role == 'project_manager'
  end

  def edit?
    @user.role == 'project_manager'
  end
end
