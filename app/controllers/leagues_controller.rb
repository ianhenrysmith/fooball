class LeaguesController < BaseController

  before_filter :get_league, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :edit]

  def index
    @leagues = League.limit(100).to_a

    league_ids = @leagues.map(&:id)
    @teams = Team.where(:league_id.in => league_ids).to_a
  end

  def show
    @stories = Story.for_parent(@league).to_a
  end

  def edit

  end

  def update
    @league.update_attributes(league_params)

    redirect_to league_path(@league)
  end

  def new
  end

  def create
    create_league

    get_associated

    redirect_to league_path(@league)
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