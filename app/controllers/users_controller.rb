class UsersController < BaseController

  before_filter :find_user, only: [:show, :edit, :update]
  before_filter :get_associated, only: [:show, :edit, :update]

  def index
  
  end

  def show
    
  end

  def edit

  end

  def update
    redirect_to root_path unless @user.id == current_user.id

    @user.attributes = mass_assignable_atts

    process_uploads(asset_params, @user)

    @user.save

    render :show
  end

  private
  
  def user_params
    @_params ||= params.require(:user).permit(:name, :asset)
  end

  def asset_params
    user_params.slice(:asset)
  end

  def mass_assignable_atts
    user_params.slice(:name)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def get_associated
    @leagues = League.with_user(@user)
    @teams = Team.for_user(@user)
  end


end