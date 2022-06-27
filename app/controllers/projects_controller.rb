class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_project, only: [:show, :edit, :update, :destroy, :show_button]

  def index
    @projects = current_user.projects
  end

  def show
    @users = @project.users
    @available_users = User.where.not(id: @users)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Assign.new(user_id: current_user.id, project_id: Project.last.id).save
      redirect_to projects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @project
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path, status: :see_other
  end

  def show_button
    authorize @project
    if params[:assign_user]
      Assign.new(user_id: params[:assign_user], project_id: params[:id]).save
    elsif params[:remove_user]
      @get_user = Assign.where(user_id: params[:remove_user], project_id: params[:id]).first
      @get_user.delete
    end
    redirect_to project_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def current_project
    @project = Project.find(params[:id])
  end

end
