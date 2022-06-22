class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    puts @user.image.attached?
    arr = []
    @p = Assign.where(user_id: @user.id)
    @p.each do |pp|
      arr.push(pp.project_id)
    end
    @projects = Project.where(id: arr)
  end

  def show
    @project = Project.find(params[:id])
    @users = @project.users
    @available_users = User.where.not(id: @users)
    if params[:assign_user]
      authorize @project
      Assign.new(user_id: params[:assign_user], project_id: params[:id]).save
      redirect_to project_path
    end
    if params[:remove_user]
      authorize @project
      @get_users = Assign.where(user_id: params[:remove_user], project_id: params[:id])
      @get_users.each do |gu|
        gu.delete
      end
      redirect_to project_path
    end
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
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
