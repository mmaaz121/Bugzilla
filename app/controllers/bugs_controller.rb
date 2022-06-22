class BugsController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @bugs = Bug.where(project_id: @project.id)
  end

  def show
    @bug = Bug.find(params[:id])
    @project = Project.find(params[:project_id])
    @bugs = Bug.where(project_id: @project.id)
  end

  def new
    @project = Project.find(params[:project_id])
    @bug = Bug.new
    authorize @bug
    @users = @project.users
  end

  def create
    @project = Project.find(params[:project_id])
    @users = @project.users
    @u = User.find_by(email: params[:bug][:user_id])
    params[:bug][:user_id] = @u.id
    params[:bug][:status] = 'new_bug'
    @bug = @project.bugs.new(bug_params)
    if @bug.save
      redirect_to project_bugs_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @bug = Bug.find(params[:id])
    authorize @bug if @bug.status == 'fixed' or @bug.user_id != current_user.id
    @users = @project.users
  end

  def update
    @project = Project.find(params[:project_id])
    @users = @project.users
    @u = User.find_by(email: params[:bug][:user_id])
    params[:bug][:user_id] = @u.id
    @bug = Bug.find(params[:id])
    if @bug.update(bug_params)
      redirect_to project_bugs_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    redirect_to project_bugs_path, status: :see_other
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :comment, :user_id, :status)
  end
end
