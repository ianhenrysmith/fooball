class LeaguesController < BaseController

  before_filter :get_league, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :edit]

  RESOURCE_NAME = :league
  WHITELISTED_PARAMS = [:name]

  def index
    @leagues = League.limit(100).to_a

    league_ids = @leagues.map(&:id)
    @teams = Team.where(:league_id.in => league_ids).to_a
  end

  def show
    @stories = Story.for_parent(@league).order_by(:created_at.desc).to_a
    @topics = Topic.for_parent(@league).order_by(:updated_at.desc).to_a
  end

  def edit

  end

  def update
    redirect_to root_path unless @league.admin?(current_user)

    @league.attributes = mass_assignable_atts

    process_uploads(asset_params, @league)

    @league.save

    redirect_to league_path(@league)
  end

  def new
  end

  def create
    create_league

    redirect_to league_path(@league)
  end

  private

  def create_league
    # could use `instance_variable_set("@#{:smoo}", 8)` to dry up more
    @league.attributes = mass_assignable_atts

    @league.save
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
    @admins ||= @users.select{|u| @league.admin?(u)}
    @teams ||= @league.teams
    @rankings ||= @league.rankings
    @users_by_team_id ||= get_users_by_team_id
  end

end