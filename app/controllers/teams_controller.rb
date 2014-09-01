class TeamsController < BaseController

  before_filter :get_team, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :update]

  RESOURCE_NAME = :team
  WHITELISTED_PARAMS = [:name, :owner_id, :league_id]
  PROCESS_ASSETS = true

  def index
  
  end

  def show

  end

  def new
    @league = @team.league
  end

  def update
    update_resource

    redirect_to team_path(@team)
  end

  def create
    if update_resource
      get_associated

      @league.add_team!(@team)
    end

    flash.notice = "Team Created"

    redirect_to league_path(@league)
  end

  private

  def get_team
    if params[:id]
      @team ||= Team.find(params[:id])
    end

    @team ||= new_team
  end

  def get_associated
    @owner = @team.owner
    @league = @team.league
  end

  def new_team
    Team.new(owner_id: current_user.id, league_id: params[:league_id])
  end

end