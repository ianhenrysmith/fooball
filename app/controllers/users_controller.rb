class UsersController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  before_filter :find_user, only: [:show, :edit, :update]
  before_filter :get_associated, only: [:show, :edit, :update]

  def index
  
  end

  def show
    
  end

  def edit

  end

  def update
    @user.update_attributes(user_params)

    render :show
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :image_url)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def get_associated
    @leagues = League.with_user(@user)
    @teams = Team.for_user(@user)
  end


end