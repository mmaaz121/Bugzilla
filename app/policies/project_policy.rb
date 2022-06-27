class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
    end
  end

  def index?
    user.project_manager?
  end

  def show?
    index?
    # user.projects.include? record
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def show_button?
    index?
  end
end
