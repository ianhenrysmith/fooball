class LeaguesController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  before_filter :get_league, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :edit, :update]

  def index
  
  end

  def show
    
  end

  def edit

  end

  def update
    @league.update_attributes(league_params)

    render :show
  end

  def new
  end

  def create
    create_league

    get_associated

    render :show
  end

  private

  def create_league
    @league.name = league_params[:name]

    @league.save
  end

  def league_params
    params.require(:league).permit(:name)
  end

  def get_league
    if params[:id]
      @league ||= League.find(params[:id])
    end

    @league ||= new_league
  end

  def new_league
    League.new(creator_id: current_user.id, admin_ids: [current_user.id], user_ids: [current_user.id])
  end

  def get_associated
    @users ||= @league.users
    @admins ||= @users.select{|u| @league.admin_ids.include?(u.id)}
    @teams ||= @league.teams
    @users_by_team_id ||= Hash[@teams.map {|t| [t.id, @users.detect{|u| u.id == t.owner_id}]}]
  end

end