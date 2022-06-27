class FeaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_project, only: [:index, :show, :new, :create, :edit, :update]

  def index
    @features = Feature.where(project_id: @project.id)
  end

  def show
    @feature = Feature.find(params[:id])
    @features = Feature.where(project_id: @project.id)
  end

  def new
    @feature = Feature.new
    authorize @feature
    @users = @project.users
  end

  def create
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
    @feature = Feature.find(params[:id])
    authorize @feature if @feature.status == 'complete' or @feature.user_id != current_user.id
    @users = @project.users
  end

  def update
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

  def current_project
    @project = Project.find(params[:project_id])
  end

end
