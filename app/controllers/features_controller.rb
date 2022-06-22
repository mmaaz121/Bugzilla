class FeaturesController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @features = Feature.where(project_id: @project.id)
  end

  def show
    @feature = Feature.find(params[:id])
    @project = Project.find(params[:project_id])
    @features = Feature.where(project_id: @project.id)
  end

  def new
    @project = Project.find(params[:project_id])
    @feature = Feature.new
    authorize @feature
    @users = @project.users
  end

  def create
    @project = Project.find(params[:project_id])
    @users = @project.users
    @u = User.find_by(email: params[:feature][:user_id])
    params[:feature][:user_id] = @u.id
    params[:feature][:status] = 'new_feature'
    @feature = @project.features.new(feature_params)
    if @feature.save
      redirect_to project_features_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @feature = Feature.find(params[:id])
    authorize @feature if @feature.status == 'complete' or @feature.user_id != current_user.id
    @users = @project.users
  end

  def update
    @project = Project.find(params[:project_id])
    @users = @project.users
    @u = User.find_by(email: params[:feature][:user_id])
    params[:feature][:user_id] = @u.id
    @feature = Feature.find(params[:id])
    if @feature.update(feature_params)
      redirect_to project_features_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to project_features_path, status: :see_other
  end

  private

  def feature_params
    params.require(:feature).permit(:title, :comment, :user_id, :status)
  end
end
