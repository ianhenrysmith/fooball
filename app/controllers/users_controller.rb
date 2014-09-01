class UsersController < BaseController

  before_filter :find_user, only: [:show, :edit, :update]
  before_filter :get_associated, only: [:show, :edit, :update]

  RESOURCE_NAME = :user
  WHITELISTED_PARAMS = [:name]
  PROCESS_ASSETS = true

  # users are created via OmniauthCallbacksController

  def index
  
  end

  def show
    
  end

  def edit

  end

  def update
    redirect_to root_path unless @user.id == current_user.id

    update_resource

    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def get_associated
    @leagues = League.with_user(@user)
    @teams = Team.for_user(@user)
  end


end