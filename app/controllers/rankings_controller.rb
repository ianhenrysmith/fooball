
class RankingsController < BaseController

  before_filter :get_ranking, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :edit, :new, :create]

  RESOURCE_NAME = :ranking
  WHITELISTED_PARAMS = [:league_id, :created_at_date, :week, :body, :title]
  DEEP_PARAMS = [:team_rankings]

  def index
    # not used
  end

  def show

  end

  def new

  end

  def update
    # not used
  end

  def create
    update_resource

    send_ranking_email_from(current_user)

    redirect_to(@ranking)
  end

  def edit
    # not used
  end

  private

  def get_ranking
    if params[:id]
      @ranking ||= Ranking.find(params[:id])
    end

    @ranking ||= new_ranking
  end

  def new_ranking
    atts = { creator_id: current_user.id }

    ranking = Ranking.new(atts.merge(mass_assignable_atts))

    ranking.set_created_at_date(Date.today) # sets week, might want to just to that on Ranking#init

    ranking
  end

  def get_associated
    @league ||= @ranking.league
    @users ||= @league.users
    @teams ||= @league.teams
    @users_by_team_id ||= get_users_by_team_id
  end

  def send_ranking_email_from(creator)
    for user in @users
      @message = RankingNotifier.send_ranking_email(@ranking, creator, user, @league)
      @message.deliver! if Rails.env.production?
    end
  end

end