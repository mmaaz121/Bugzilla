class BugPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    @user.role != 'developer'
  end

  def show?
    @user.role != 'developer'
  end

  def new?
    @user.role != 'developer'
  end

  def edit?
    @user.role != 'developer'
  end
end
