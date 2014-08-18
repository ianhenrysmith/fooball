class UsersController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  def index
  
  end

  def show
    @user = User.find(params[:id])
    @leagues = League.with_user(@user)
    @teams = Team.for_user(@user)
  end

end