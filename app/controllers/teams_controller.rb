class TeamsController < BaseController

  before_filter :get_team, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :update]

  def index
  
  end

  def show

  end

  def new
    @league = @team.league
  end

  def update
    @team.update_attributes(team_params)

    render :show
  end

  def create
    if create_team
      get_associated

      add_team_to_league
    end

    flash.notice = "Team Created"

    redirect_to league_path(@league)
  end

  private

  def create_team
    @team.name = team_params[:name]
    @team.league_id = team_params[:league_id]
    @team.owner_id = current_user.id

    @team.save
  end

  def add_team_to_league
    @league.user_ids << @team.owner_id
    @league.team_ids << @team.id

    @league.save
  end

  def team_params
    params.require(:team).permit(:name, :league_id)
  end

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